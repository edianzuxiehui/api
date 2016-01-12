package com.xiehui.api.permission.secret;

import java.text.*;
import java.util.*;

public class APIUtil {

	public static String getCurrentTime() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(new Date());
	}
	
	
}
