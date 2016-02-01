package com.xiehui.api.customer.util;

import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class HttpHelperThreadPool {

	private static final ThreadPoolExecutor parseExc = new ThreadPoolExecutor(10, 100, 20L, TimeUnit.SECONDS,
			new LinkedBlockingQueue<Runnable>());

	public static void parseAndSaveCellInfo() {
		parseExc.execute(new Runnable() {
			public void run() {

			}
		});
	}

}
