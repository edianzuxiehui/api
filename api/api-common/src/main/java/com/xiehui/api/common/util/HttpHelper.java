package com.xiehui.api.common.util;

import javax.net.ssl.*;

import com.xiehui.api.common.exception.APIException;

import java.io.*;
import java.net.*;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.*;

/**
 * HTTP工具类
 * 
 * @author xiehui
 *
 */
public class HttpHelper {
	public static int DEFAULT_CONNECT_TIMEOUT = 5000;
	public static int DEFAULT_READ_TIMEOUT = 5000;
	private static final String DEFAULT_CHARSET = "UTF-8";
	private static final String METHOD_POST = "POST";
	private static final String METHOD_GET = "GET";
	private static final String AGENT = "edianzu ecm client v1.0.0";

	private static class DefaultTrustManager implements X509TrustManager {
		public X509Certificate[] getAcceptedIssuers() {
			return null;
		}

		public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
		}

		public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
		}
	}

	private HttpHelper() {
	}

	public static String doPost(String url, Map params) throws APIException {
		return doPost(url, params, DEFAULT_CHARSET, DEFAULT_CONNECT_TIMEOUT, DEFAULT_READ_TIMEOUT);
	}

	public static String doPost(String url, Map params, int connectTimeout, int readTimeout) throws APIException {
		return doPost(url, params, DEFAULT_CHARSET, connectTimeout, readTimeout);
	}

	public static String doPost(String url, Map params, String charset, int connectTimeout, int readTimeout)
			throws APIException {
		return doPost(url, params, charset, connectTimeout, readTimeout, null);
	}

	public static String doPost(String url, Map params, String charset, int connectTimeout, int readTimeout,
			Map headerMap) throws APIException {
		String contentType = "application/x-www-form-urlencoded;charset=" + charset;
		String query = buildQuery(params, charset);
		byte[] content = null;
		if (query != null) {
			try {
				content = query.getBytes(charset);
			} catch (UnsupportedEncodingException e) {
				throw new APIException("不支持的编码");
			}
		}
		return _doPost(url, contentType, content, connectTimeout, readTimeout, headerMap);
	}

	public static String doPost(String url, String contentType, byte[] content, int connectTimeout, int readTimeout)
			throws APIException {
		return _doPost(url, contentType, content, connectTimeout, readTimeout, null);
	}

	public static String doGet(String url, Map params) throws APIException {
		return doGet(url, params, DEFAULT_CONNECT_TIMEOUT, DEFAULT_READ_TIMEOUT);
	}

	public static String doGet(String url, Map params, int connectTimeout, int readTimeout) throws APIException {
		return doGet(url, params, DEFAULT_CHARSET, connectTimeout, readTimeout);
	}

	public static String doGet(String url, Map params, String charset, int connectTimeout, int readTimeout)
			throws APIException {
		HttpURLConnection conn = null;
		String rsp = null;

		try {
			String contentType = "application/x-www-form-urlencoded;charset=" + charset;
			String query = buildQuery(params, charset);
			try {
				conn = getConnection(buildGetUrl(url, query), METHOD_GET, contentType, null);
				conn.setConnectTimeout(connectTimeout);
				conn.setReadTimeout(readTimeout);
			} catch (Exception e) {
				throw new APIException(e);
			}

			try {
				rsp = getResponseAsString(conn);
			} catch (Exception e) {
				throw new APIException(e);
			}

		} finally {
			if (conn != null) {
				conn.disconnect();
			}
		}

		return rsp;
	}

	public static String doPostXML(String url, String xml) throws APIException {
		return doPostXML(url, xml, DEFAULT_CHARSET, DEFAULT_CONNECT_TIMEOUT, DEFAULT_READ_TIMEOUT);
	}

	public static String doPostXML(String url, String xml, String charset) throws APIException {
		return doPostXML(url, xml, charset, DEFAULT_CONNECT_TIMEOUT, DEFAULT_READ_TIMEOUT);
	}

	public static String doPostXML(String url, String xml, String charset, int connectTimeout, int readTimeout)
			throws APIException {
		try {
			return _doPost(url, "application/xml;charset=" + charset, xml.getBytes(charset), connectTimeout,
					readTimeout, null);
		} catch (UnsupportedEncodingException e) {
			throw new APIException(e);
		}
	}

	public static String doPostJSON(String url, String json, String charset, Map<String, String> headerMap)
			throws APIException {
		return doPostJSON(url, json, charset, DEFAULT_CONNECT_TIMEOUT, DEFAULT_READ_TIMEOUT, headerMap);
	}

	public static String doPostJSON(String url, String json, String charset) throws APIException {
		return doPostJSON(url, json, charset, DEFAULT_CONNECT_TIMEOUT, DEFAULT_READ_TIMEOUT, null);
	}

	public static String doPostJSON(String url, String json, String charset, int connectTimeout, int readTimeout,
			Map<String, String> headerMap) throws APIException {
		try {
			return _doPost(url, "application/json;charset=" + charset, json.getBytes(charset), connectTimeout,
					readTimeout, headerMap);
		} catch (UnsupportedEncodingException e) {
			throw new APIException(e);
		}
	}

	private static String _doPost(String url, String contentType, byte[] content, int connectTimeout, int readTimeout,
			Map<String, String> headerMap) throws APIException {
		HttpURLConnection conn = null;
		OutputStream out = null;
		String rsp = null;
		try {
			try {
				conn = getConnection(new URL(url), METHOD_POST, contentType, headerMap);
				conn.setConnectTimeout(connectTimeout);
				conn.setReadTimeout(readTimeout);
			} catch (IOException e) {
				throw new APIException(e);
			}
			try {
				out = conn.getOutputStream();
				out.write(content);
				out.flush();
				rsp = getResponseAsString(conn);
			} catch (IOException e) {
				throw new APIException(e);
			}
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (conn != null) {
					conn.disconnect();
				}
			} catch (Throwable ignore) {
			}
		}
		return rsp;
	}

	private static HttpURLConnection getConnection(URL url, String method, String contentType,
			Map<String, String> headerMap) throws APIException {
		HttpURLConnection conn = null;
		if ("https".equals(url.getProtocol())) {
			SSLContext ctx = null;
			try {
				ctx = SSLContext.getInstance("TLS");
				ctx.init(new KeyManager[0], new DefaultTrustManager[0], new SecureRandom());
			} catch (Exception e) {
				throw new APIException(e);
			}

			HttpsURLConnection connHttps;
			try {
				connHttps = (HttpsURLConnection) url.openConnection();
			} catch (IOException e) {
				throw new APIException(e);
			}
			connHttps.setSSLSocketFactory(ctx.getSocketFactory());
			connHttps.setHostnameVerifier(new HostnameVerifier() {
				public boolean verify(String hostname, SSLSession session) {
					return true;
				}
			});
			conn = connHttps;
		} else {
			try {
				conn = (HttpURLConnection) url.openConnection();
			} catch (IOException e) {
				throw new APIException(e);
			}
		}

		try {
			conn.setRequestMethod(method);
		} catch (ProtocolException e) {
			throw new APIException(e);
		}
		conn.setDoInput(true);
		conn.setDoOutput(true);
		conn.setRequestProperty("User-Agent", AGENT);
		conn.setRequestProperty("Content-Type", contentType);
		if (headerMap != null) {
			Iterator headerMapIterator = headerMap.keySet().iterator();
			while (headerMapIterator.hasNext()) {
				String key = (String) headerMapIterator.next();
				String value = headerMap.get(key);
				conn.setRequestProperty(key, value);
			}
		}
		return conn;
	}

	public static String buildQuery(Map params, String charset) throws APIException {
		if (params == null) {
			return null;
		}

		StringBuilder query = new StringBuilder();
		Iterator iterator = params.keySet().iterator();
		boolean hasParam = false;
		while (iterator.hasNext()) {
			String name = (String) iterator.next();
			String value = params.get(name).toString();
			if (name != null && value != null) {
				if (hasParam) {
					query.append('&');
				} else {
					hasParam = true;
				}
				try {
					query.append(name).append('=').append(URLEncoder.encode(value, charset));
				} catch (UnsupportedEncodingException e) {
					throw new APIException(e);
				}
			}

		}
		System.out.println(query.toString());
		return query.toString();
	}

	private static URL buildGetUrl(String strUrl, String query) throws APIException {
		URL url;
		try {
			url = new URL(strUrl);
		} catch (MalformedURLException e) {
			throw new APIException(e);
		}
		if (query == null) {
			return url;
		}

		if (url.getQuery() == null) {
			if (strUrl.endsWith("?")) {
				strUrl = strUrl + query;
			} else {
				strUrl = strUrl + '?' + query;
			}
		} else {
			if (strUrl.endsWith("&")) {
				strUrl = strUrl + query;
			} else {
				strUrl = strUrl + '&' + query;
			}
		}

		try {
			return new URL(strUrl);
		} catch (MalformedURLException e) {
			throw new APIException(e);
		}
	}

	protected static String getResponseAsString(HttpURLConnection conn) throws APIException {
		String charset = getResponseCharset(conn.getContentType());
		InputStream es = conn.getErrorStream();
		if (es == null) {
			try {
				return getStreamAsString(conn.getInputStream(), charset);
			} catch (IOException e) {
				throw new APIException(e);
			}
		} else {
			String msg = getStreamAsString(es, charset);
			if (msg == null) {
				try {
					throw new APIException(conn.getResponseCode() + ":" + conn.getResponseMessage());
				} catch (IOException e) {
					throw new APIException(e);
				}
			} else {
				throw new APIException(msg);
			}
		}
	}

	private static String getStreamAsString(InputStream stream, String charset) throws APIException {
		Reader reader = null;
		try {
			try {
				reader = new InputStreamReader(stream, charset);
			} catch (UnsupportedEncodingException e) {
				throw new APIException(e);
			}
			StringBuilder response = new StringBuilder();

			char[] buff = new char[1024];
			int read = 0;
			try {
				while ((read = reader.read(buff)) > 0) {
					response.append(buff, 0, read);
				}
			} catch (IOException e) {
				throw new APIException(e);
			}

			return response.toString();
		} finally {
			try {
				stream.close();
				reader.close();
			} catch (Throwable ignore) {
			}
		}
	}

	private static String getResponseCharset(String ctype) {
		String charset = DEFAULT_CHARSET;
		if (ctype != null) {
			String[] params = ctype.split(";");
			for (String param : params) {
				param = param.trim();
				if (param.startsWith("charset")) {
					String[] pair = param.split("=", 2);
					if (pair.length == 2) {
						if (pair[1] == null) {
							charset = pair[1].trim();
						}
					}
					break;
				}
			}
		}

		return charset;
	}

	public static void main(String[] args) {

	}
}
