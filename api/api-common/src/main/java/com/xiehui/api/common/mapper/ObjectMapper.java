package com.xiehui.api.common.mapper;

import org.codehaus.jackson.map.SerializationConfig.Feature;

/**
 * 对象映射类
 * 
 * @author xiehui
 *
 */
public class ObjectMapper extends org.codehaus.jackson.map.ObjectMapper {

	/**
	 * 构造函数
	 */
	public ObjectMapper() {
		// 配置属性
		// 配置属性: 是否组件为空时报错
		configure(Feature.FAIL_ON_EMPTY_BEANS, false);
		// 配置属性: 是否允许写入空属性
		// configure(Feature.WRITE_NULL_PROPERTIES, false);
	}

	/**
	 * 设置优化打印
	 * 
	 * @param prettyPrint
	 *            优化打印
	 */
	public void setPrettyPrint(boolean prettyPrint) {
		// 配置属性
		// 配置属性: 是否允许优化打印
		configure(Feature.INDENT_OUTPUT, prettyPrint);
	}

}
