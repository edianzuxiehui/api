package com.xiehui.api.permission.secret;

import java.util.concurrent.*;

import com.xiehui.api.common.exception.APIException;

/**
 * 谷歌身份证验证器
 * 
 * @author xiehui
 *
 */
public class Authenticator {

	/**
	 * 验证密码
	 * 
	 * @param secret
	 *            密钥
	 * @param validation_code
	 *            密码
	 * @return
	 * @throws APIException
	 *             API异常
	 */
	public static boolean check(String secret, int validation_code) throws APIException {
		GoogleAuthenticatorConfigBuilder gacb = new GoogleAuthenticatorConfigBuilder()
				.setTimeStepSizeInMillis(TimeUnit.SECONDS.toMillis(30)).setWindowSize(5);
		GoogleAuthenticator ga = new GoogleAuthenticator(gacb.build());

		boolean isCodeValid = ga.authorize(secret, validation_code);

		return isCodeValid;
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

			config.setCodeDigits(codeDigits);
			config.setKeyModulus((int) Math.pow(10, codeDigits));
			return this;
		}

		public GoogleAuthenticatorConfigBuilder setTimeStepSizeInMillis(long timeStepSizeInMillis) throws APIException {
			if (timeStepSizeInMillis <= 0) {
				throw new APIException("Time step size must be positive.");
			}

			config.setTimeStepSizeInMillis(timeStepSizeInMillis);
			return this;
		}

		public GoogleAuthenticatorConfigBuilder setWindowSize(int windowSize) throws APIException {
			if (windowSize <= 0) {
				throw new APIException("Window number must be positive.");
			}

			config.setWindowSize(windowSize);
			return this;
		}

		public GoogleAuthenticatorConfigBuilder setKeyRepresentation(KeyRepresentation keyRepresentation)
				throws APIException {
			if (keyRepresentation == null) {
				throw new APIException("Key representation cannot be null.");
			}

			config.setKeyRepresentation(keyRepresentation);
			return this;
		}
	}

}
