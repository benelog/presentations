package helloworld.android.util;

import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

public class RestTeamplteUtils {
	public static void setTimeout(RestTemplate template, int connectTimeout, int readTimeout){
		ClientHttpRequestFactory requestFactory = template.getRequestFactory();
		
		if (requestFactory instanceof SimpleClientHttpRequestFactory) {
			SimpleClientHttpRequestFactory factory = (SimpleClientHttpRequestFactory)requestFactory;
			factory.setConnectTimeout(connectTimeout);
			factory.setReadTimeout(readTimeout);
			
		}	else if (requestFactory instanceof HttpComponentsClientHttpRequestFactory) {
			HttpComponentsClientHttpRequestFactory factory = (HttpComponentsClientHttpRequestFactory)requestFactory;
			factory.setConnectTimeout(connectTimeout);
			factory.setReadTimeout(readTimeout);
		}
	}
}
