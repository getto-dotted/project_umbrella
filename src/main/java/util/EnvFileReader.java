package util;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MutablePropertySources;
import org.springframework.core.io.support.ResourcePropertySource;

public class EnvFileReader {

	public static String getValue(String envFile, String keyName) {
		
		//1.스프링 컨테이너 생성
		ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();
		//2.Environment 객체 생성
		ConfigurableEnvironment env = ctx.getEnvironment();
		//3.getPropertySources() 메소드를 통해 외부파일을 읽을 준비를 함.
		MutablePropertySources propertySources = env.getPropertySources();
		//외부파일에서 읽어온 내용을 저장할 변수
		String envStr = "";
		
		
		try {/*
			4.외부 프로퍼티 파일의 경로를 지정한 후 addLast()를 통해
			프로퍼티소스에 추가한다.
			*/
			String envPath = "classpath:"+envFile;//OracleInfo.properties
			propertySources.addLast(new ResourcePropertySource(envPath));
			//5.파일의 내용을 읽어서 변수에 저장함
			envStr = env.getProperty(keyName);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return envStr;
	}
}
