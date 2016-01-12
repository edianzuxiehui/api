package com.xiehui.api.common.util;

import com.xiehui.api.common.exception.*;

/**
 * 将十五位身份证号码转换为十八位
 * 
 * @author xiehui
 *
 */
public class IdCardNoHelper {

	/**
	 * 根据15位身份证号码转换为18位身份证号码
	 * 
	 * @param fifteenIDCard 身份证号码
	 * @return 返回的18位身份证号码
	 * @throws APIException API异常
	 */
	public static String getEighteenIDCard(String fifteenIDCard) throws APIException {
		if (fifteenIDCard.length() == 15) {
			StringBuilder sb = new StringBuilder();
			sb.append(fifteenIDCard.substring(0, 6)).append("19").append(fifteenIDCard.substring(6));
			sb.append(getVerifyCode(sb.toString()));
			return sb.toString();
		}
		else {
			return fifteenIDCard;
		}
	}

	/**
	 * 获取校验码
	 * 
	 * @param idCardNumber 不带校验位的身份证号码（17位）
	 * @return 校验码
	 * @throws APIException 如果身份证没有加上19，则抛出异常
	 */
	public static char getVerifyCode(String idCardNumber) throws APIException {
		if (idCardNumber == null || idCardNumber.length() < 17) {
			throw new APIException("不合法的身份证号码");
		}
		char[] Ai = idCardNumber.toCharArray();
		int[] Wi = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
		char[] verifyCode = { '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2' };
		int S = 0;
		int Y;
		for (int i = 0; i < Wi.length; i++) {
			S += (Ai[i] - '0') * Wi[i];
		}
		Y = S % 11;
		return verifyCode[Y];
	}

}
