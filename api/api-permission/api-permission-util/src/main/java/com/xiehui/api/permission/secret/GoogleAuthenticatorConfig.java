package com.xiehui.api.permission.secret;

import java.util.concurrent.TimeUnit;

import com.xiehui.api.common.exception.APIException;

public class GoogleAuthenticatorConfig {
	private long timeStepSizeInMillis = TimeUnit.SECONDS.toMillis(30);
	private int windowSize = 3;
	private int codeDigits = 6;
	private int keyModulus = (int) Math.pow(10, codeDigits);
	private KeyRepresentation keyRepresentation = KeyRepresentation.BASE32;

	public void setWindowSize(int windowSize) {
		this.windowSize = windowSize;
	}

	public void setKeyRepresentation(KeyRepresentation keyRepresentation) {
		this.keyRepresentation = keyRepresentation;
	}

	public void setTimeStepSizeInMillis(long timeStepSizeInMillis) {
		this.timeStepSizeInMillis = timeStepSizeInMillis;
	}

	public void setCodeDigits(int codeDigits) {
		this.codeDigits = codeDigits;
	}

	public void setKeyModulus(int keyModulus) {
		this.keyModulus = keyModulus;
	}

	public int getKeyModulus() {
		return keyModulus;
	}

	public KeyRepresentation getKeyRepresentation() {
		return keyRepresentation;
	}

	public int getCodeDigits() {
		return codeDigits;
	}

	public long getTimeStepSizeInMillis() {
		return timeStepSizeInMillis;
	}

	public int getWindowSize() {
		return windowSize;
	}

	public static class GoogleAuthenticatorConfigBuilder {
		private GoogleAuthenticatorConfig config = new GoogleAuthenticatorConfig();

		public GoogleAuthenticatorConfig build() {
			return config;
		}

		public GoogleAuthenticatorConfigBuilder setCodeDigits(int codeDigits) throws APIException {
			if (codeDigits <= 0) {
				throw new APIException("Code digits must be positive.");
			}

			if (codeDigits < 6) {
				throw new APIException("The minimum number of digits is 6.");
			}

			if (codeDigits > 8) {
				throw new APIException("The maximum number of digits is 8.");
			}

			config.codeDigits = codeDigits;
			config.keyModulus = (int) Math.pow(10, codeDigits);
			return this;
		}

		public GoogleAuthenticatorConfigBuilder setTimeStepSizeInMillis(long timeStepSizeInMillis) throws APIException {
			if (timeStepSizeInMillis <= 0) {
				throw new APIException("Time step size must be positive.");
			}

			config.timeStepSizeInMillis = timeStepSizeInMillis;
			return this;
		}

		public GoogleAuthenticatorConfigBuilder setWindowSize(int windowSize) throws APIException {
			if (windowSize <= 0) {
				throw new APIException("Window number must be positive.");
			}

			config.windowSize = windowSize;
			return this;
		}

		public GoogleAuthenticatorConfigBuilder setKeyRepresentation(KeyRepresentation keyRepresentation)
				throws APIException {
			if (keyRepresentation == null) {
				throw new APIException("Key representation cannot be null.");
			}

			config.keyRepresentation = keyRepresentation;
			return this;
		}
	}
}
