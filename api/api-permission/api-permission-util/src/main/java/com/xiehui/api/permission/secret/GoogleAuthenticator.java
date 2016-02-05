package com.xiehui.api.permission.secret;

import org.apache.commons.codec.binary.Base32;
import org.apache.commons.codec.binary.Base64;

import com.xiehui.api.common.exception.APIException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public final class GoogleAuthenticator {

	private static final Logger LOGGER = Logger.getLogger(GoogleAuthenticator.class.getName());

	private static final int SCRATCH_CODE_LENGTH = 8;

	public static final int SCRATCH_CODE_MODULUS = (int) Math.pow(10, SCRATCH_CODE_LENGTH);

	private static final String HMAC_HASH_FUNCTION = "HmacSHA1";

	private final GoogleAuthenticatorConfig config;

	public GoogleAuthenticator() {
		config = new GoogleAuthenticatorConfig();
	}

	public GoogleAuthenticator(GoogleAuthenticatorConfig config) throws APIException {
		if (config == null) {
			throw new APIException("Configuration cannot be null.");
		}

		this.config = config;
	}

	int calculateCode(byte[] key, long tm) throws APIException {
		byte[] data = new byte[8];
		long value = tm;

		for (int i = 8; i-- > 0; value >>>= 8) {
			data[i] = (byte) value;
		}

		SecretKeySpec signKey = new SecretKeySpec(key, HMAC_HASH_FUNCTION);

		try {
			Mac mac = Mac.getInstance(HMAC_HASH_FUNCTION);
			mac.init(signKey);
			byte[] hash = mac.doFinal(data);
			int offset = hash[hash.length - 1] & 0xF;
			long truncatedHash = 0;
			for (int i = 0; i < 4; ++i) {
				truncatedHash <<= 8;
				truncatedHash |= (hash[offset + i] & 0xFF);
			}
			truncatedHash &= 0x7FFFFFFF;
			truncatedHash %= config.getKeyModulus();
			return (int) truncatedHash;
		} catch (Exception ex) {
			LOGGER.log(Level.SEVERE, ex.getMessage(), ex);
			throw new APIException("The operation cannot be " + "performed now.");
		}
	}

	private boolean checkCode(String secret, long code, long timestamp, int window) throws APIException {
		byte[] decodedKey;
		switch (config.getKeyRepresentation()) {
		case BASE32:
			Base32 codec32 = new Base32();
			decodedKey = codec32.decode(secret);
			break;
		case BASE64:
			Base64 codec64 = new Base64();
			decodedKey = codec64.decode(secret);
			break;
		default:
			throw new APIException("Unknown key representation type.");
		}
		final long timeWindow = timestamp / this.config.getTimeStepSizeInMillis();
		for (int i = -((window - 1) / 2); i <= window / 2; ++i) {
			long hash = calculateCode(decodedKey, timeWindow + i);
			if (hash == code) {
				return true;
			}
		}
		return false;
	}

	boolean validateScratchCode(int scratchCode) {
		return (scratchCode >= SCRATCH_CODE_MODULUS / 10);
	}

	public boolean authorize(String secret, int verificationCode) throws APIException {
		if (secret == null) {
			throw new APIException("Secret cannot be null.");
		}
		if (verificationCode <= 0 || verificationCode >= this.config.getKeyModulus()) {
			return false;
		}
		return checkCode(secret, verificationCode, new Date().getTime(), this.config.getWindowSize());
	}
}
