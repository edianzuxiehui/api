package com.xiehui.api.common.util;

import java.sql.*;
import java.text.*;

import com.xiehui.api.common.exception.*;

/**
 * 时间辅助类
 * 
 * @author xiehui
 *
 */
public class TimeHelper {

	/** 常量相关 */
	/** 日期格式 */
	private final static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	/** 时间格式 */
	private final static SimpleDateFormat TIME_FORMAT = new SimpleDateFormat("HH:mm:ss");
	/** 时间戳格式 */
	private final static SimpleDateFormat TIMESTAMP_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/**
	 * 获取当前日期
	 * 
	 * @return 当前日期字符串
	 */
	public static String getDate() {
		return DATE_FORMAT.format(new java.util.Date());
	}

	/**
	 * 根据格式获取当前时间
	 * 
	 * @param format 格式
	 * @return 当前日期字符串
	 */
	public static String getDateByFormat(String format) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
		return simpleDateFormat.format(new java.util.Date());
	}

	/**
	 * 获取指定日期
	 * 
	 * @param date 指定日期
	 * @return 指定日期字符串
	 */
	public static String getDate(Date date) {
		// 检查空值
		if (date == null) {
			return null;
		}

		// 转化日期
		return DATE_FORMAT.format(date);
	}

	/**
	 * 获取指定日期
	 * 
	 * @param date 指定日期字符串
	 * @return 指定日期
	 * @throws APIException API异常
	 */
	public static Date getDate(String date) throws APIException {
		// 检查空值
		if (date == null) {
			return null;
		}

		// 转化日期
		try {
			return new Date(DATE_FORMAT.parse(date).getTime());
		}
		catch (ParseException e) {
			throw new APIException("日期(" + date + ")格式异常");
		}
	}

	/**
	 * 获取当前时间戳
	 * 
	 * @return 当前时间戳字符串
	 */
	public static String getTimestamp() {
		return TIMESTAMP_FORMAT.format(new java.util.Date());
	}

	/**
	 * 获取指定时间戳
	 * 
	 * @param timestamp 指定时间戳
	 * @return 指定时间戳字符串
	 */
	public static String getTimestamp(Timestamp timestamp) {
		// 检查空值
		if (timestamp == null) {
			return null;
		}

		// 转化时间
		return TIMESTAMP_FORMAT.format(new java.util.Date(timestamp.getTime()));
	}

	/**
	 * 获取指定时间戳
	 * 
	 * @param timestamp 指定时间戳字符串
	 * @return 指定时间戳
	 * @throws APIException API异常
	 */
	public static Timestamp getTimestamp(String timestamp) throws APIException {
		// 检查空值
		if (timestamp == null) {
			return null;
		}

		// 转化时间
		try {
			return new Timestamp(TIMESTAMP_FORMAT.parse(timestamp).getTime());
		}
		catch (ParseException e) {
			throw new APIException("时间戳(" + timestamp + ")格式异常");
		}
	}

	public static String getTimestamp(String timestamp, String format) {
		if (timestamp == null || timestamp.isEmpty() || timestamp.equals("null")) {
			return null;
		}
		if (format == null || format.isEmpty())
			format = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(new Date(Long.valueOf(timestamp + "000")));
	}

	/**
	 * 获取当前时间
	 * 
	 * @return 当前时间字符串
	 */
	public static String getTime() {
		return TIME_FORMAT.format(new java.util.Date());
	}

	/**
	 * 获取指定时间
	 * 
	 * @param time 指定时间
	 * @return 指定时间字符串
	 */
	public static String getTime(Time time) {
		// 检查空值
		if (time == null) {
			return null;
		}

		// 转化时间
		return TIME_FORMAT.format(time);
	}

	/**
	 * 获取指定时间
	 * 
	 * @param time 指定时间字符串
	 * @return 指定时间
	 * @throws APIException API异常
	 */
	public static Time getTime(String time) throws APIException {
		// 检查空值
		if (time == null) {
			return null;
		}

		// 转化时间
		try {
			return new Time(TIME_FORMAT.parse(time).getTime());
		}
		catch (ParseException e) {
			throw new APIException("时间(" + time + ")格式异常");
		}
	}

}
