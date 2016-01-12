package com.xiehui.api.permission.secret;

import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.SecureRandom;
import java.util.concurrent.atomic.AtomicInteger;

import com.xiehui.api.common.exception.APIException;

public class ReseedingSecureRandom {
	private static final int MAX_OPERATIONS = 1000000;
	private final String provider;
	private final String algorithm;
	private final AtomicInteger count = new AtomicInteger(0);
	private SecureRandom secureRandom;

	ReseedingSecureRandom() throws APIException {
		this.algorithm = null;
		this.provider = null;

		buildSecureRandom();
	}

	ReseedingSecureRandom(String algorithm) throws APIException {
		if (algorithm == null) {
			throw new APIException("Algorithm cannot be null.");
		}

		this.algorithm = algorithm;
		this.provider = null;

		buildSecureRandom();
	}

	ReseedingSecureRandom(String algorithm, String provider) throws APIException {
		if (algorithm == null) {
			throw new APIException("Algorithm cannot be null.");
		}

		if (provider == null) {
			throw new APIException("Provider cannot be null.");
		}

		this.algorithm = algorithm;
		this.provider = provider;

		buildSecureRandom();
	}

	private void buildSecureRandom() throws APIException {
		try {
			if (this.algorithm == null && this.provider == null) {
				this.secureRandom = new SecureRandom();
			} else if (this.provider == null) {
				this.secureRandom = SecureRandom.getInstance(this.algorithm);
			} else {
				this.secureRandom = SecureRandom.getInstance(this.algorithm, this.provider);
			}
		} catch (NoSuchAlgorithmException e) {
			throw new APIException(String.format(
					"Could not initialise SecureRandom " + "with the specified algorithm: %s", this.algorithm), e);
		} catch (NoSuchProviderException e) {
			throw new APIException(String.format(
					"Could not initialise SecureRandom " + "with the specified provider: %s", this.provider), e);
		}
	}

	void nextBytes(byte[] bytes) throws APIException {
		if (count.incrementAndGet() > MAX_OPERATIONS) {
			synchronized (this) {
				if (count.get() > MAX_OPERATIONS) {
					buildSecureRandom();
					count.set(0);
				}
			}
		}

		this.secureRandom.nextBytes(bytes);
	}
}
