<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h1>메인페이지 테스트</h1>
	<hr>
	<form action="/api" method="GET" id="regionSelectForm">
		<select id="regionSelect" name="region">
			<option value="Dongjak-gu">동작구</option>
			<option value="Gangnam-gu">강남구</option>		
		</select>
	</form>
	<div id="result">최고기온 : ${data.MAX_TEMP}</div>
    <script>
        $(document).ready(function() {
            $('#regionSelect').change(function() {
                const selectedRegion = $(this).val();
                $.ajax({
                    url: '/api',
                    type: 'GET',
                    data: {region: selectedRegion},
                    dataType: 'json',
                    success: function(data) {
                        $('#result').text(JSON.stringify(data));
                    },
                    error: function(err) {
                        console.error("API 호출 중 오류 발생:", err);
                    }
                });
            });
        });
    </script>
</body>
</html>