package com.study.springboot.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MainController {

	@RequestMapping("/")
	public String main() {
		
		
		return "main";
	}
	
	@RequestMapping("/api")
	@ResponseBody
	public String getData(
	    @RequestParam("address") String address,
	    Model model
	) {
	    StringBuffer result = new StringBuffer();

	    try {
	        String baseUrl = "http://openapi.seoul.go.kr:8088";	// 베이스 주소
	        String authKey = "sample"; // 개인 키 작성
	        String fileType = "json"; // 타입
	        String serviceName = "GetParkingInfo"; // 서비스 명
	        String startIdx = "1"; // 최초 번호
	        String endIdx = "100"; // 끝 번호

	        StringBuilder urlBuilder = new StringBuilder(baseUrl);
	        urlBuilder.append("/" + URLEncoder.encode(authKey, "UTF-8"));
	        urlBuilder.append("/" + fileType);
	        urlBuilder.append("/" + serviceName);
	        urlBuilder.append("/" + startIdx);
	        urlBuilder.append("/" + endIdx);
	        urlBuilder.append("/" + URLEncoder.encode(address, "UTF-8"));

	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());

	        BufferedReader rd;
	        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }

	        String line;
	        while ((line = rd.readLine()) != null) {
	            result.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(result.toString());

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result.toString(); 
	}
}
