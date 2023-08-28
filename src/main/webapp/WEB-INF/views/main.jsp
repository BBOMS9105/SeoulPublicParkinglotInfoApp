<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>서울 공영주차장 정보</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .parking-info {
            border: 1px solid black;
            margin-top: 15px;
            padding: 10px;
            max-width: 300px;
        }
    </style>
</head>
<body>
<h1>서울 공영주차장 정보</h1>
<hr>
<form action="/api" method="GET" id="getParkingInfo">
    <select id="addressSelect" name="address">
        <option value="종로구">종로구</option>
        <option value="구로구">구로구</option>
    </select>
</form>
<div id="parkingContainer"></div>
<script>
$(document).ready(function () {
    $('#addressSelect').change(function () {
        const selectedAddress = $(this).val();
        $.ajax({
            url: '/api',
            type: 'GET',
            data: {address: selectedAddress},
            dataType: 'json',
            success: function (data) {
            	/**기존 html요소 제거**/
                $('#parkingContainer').empty();
                const parkingData = data.GetParkingInfo.row;
                /**주차장 이름으로 중복 데이터 제거를 위한 배열**/
                const uniqueParkingNames = [];

                parkingData.forEach(parking => {
                    if (!uniqueParkingNames.includes(parking.PARKING_NAME)) {
                        uniqueParkingNames.push(parking.PARKING_NAME);
                        const parkingInfoDiv = '<div class="parking-info">' +
                            '<div><strong>주차장 이름 : ' + parking.PARKING_NAME + '</strong></div>' +
                            '<div>총 주차면 : ' + parking.CAPACITY + ' 대</div>' +
                            '<div>현재 주차 차량 수 : ' + parking.CUR_PARKING + ' 대</div>' +
                        '</div>';
                        $('#parkingContainer').append(parkingInfoDiv);
                    }
                });
            },
            error: function (err) {
                console.error("API 호출 중 오류 발생:", err);
            }
        });
    });
});
</script>
</body>
</html>
