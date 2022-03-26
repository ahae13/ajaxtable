<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="text" name="search" onkeyup="searchProcess()">
<button class="btn" id="btn_searchlist" >회원조회하기</button><br><br>
<input type="button" class="btn" id="btn_list" value="회원목록보기">
<hr>
<div class="container" id="list_div">
<h2>회원 목록</h2>
<hr>
<table id="tbl" border="1">
<thead>
	<tr>
		<th>번호</th><th>이름</th><th>전화번호</th>
	</tr>
</thead>

</table>
</div>
<hr>
<div class="container" id="reg_div">
<h2>회원 등록</h2>
<hr>

	번호 : <input type="text" name="num"><br>
	이름 : <input type="text" name="name"><br>
	전화번호 : <input type="text" name="tel"><br>
	<input type="button" value="등록" onclick="regProcess()">

<div id="regResult">....</div>
</div>
<hr>


<script>
	window.onload = listProcess;
	
// 등록
	var txt_num = document.querySelector("input[name='num']");
	var txt_name = document.querySelector("input[name='name']");
	var txt_tel = document.querySelector("input[name='tel']");
	var regResult = document.querySelector("#regResult");
	//var btn_submit = document.querySelector("input[type='submit']");
	
	function regProcess(){
		var num = txt_num.value;
		var name = txt_name.value;
		var tel = txt_tel.value;
		
		/* let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				regResult.innerHTML = xhr.responseText;
				listProcess();
				num.value = "";
				name.value = "";
				tel.value = "";
			}
		};
		xhr.open("get", "regMemberServlet?num=" + num + "&name="+ name + "&tel=" + tel, true);
		xhr.send(); */
		
		$.ajax({
			type: "post",
			url: "regMemberServlet"
			data: {num: num, name: name, tel: tel},
			dataType: "json",
			success: function(data){
					regResult.innerHTML = data;
					listProcess();
					num.value = "";
					name.value = "";
					tel.value = "";
				}
		});
	}
	
//회원 목록 조회
	var btn_list = document.querySelector("#btn_list");
	btn_list.addEventListener("click", listProcess);
	
	function listProcess(){
		
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			var tbl = document.querySelector("#tbl");
			tbl.innerHTML = "<thead><tr><td>번호</td><td>이름</td><td>전화번호</td></tr></thead>";
			
			if(xhr.readyState == 4 && xhr.status == 200){
				
				var jsonArray = xhr.responseText;
				var jobjList = JSON.parse(jsonArray);
				
				for(var i = 0; i < jobjList.length; i++){
					var txt_num = document.createTextNode(jobjList[i].num);
					var txt_name = document.createTextNode(jobjList[i].name);
					var txt_tel = document.createTextNode(jobjList[i].tel);
					var atag = document.createElement("a");
					atag.setAttribute("href", jobjList[i].num);
					atag.appendChild(txt_num);
					var row = tbl.insertRow(-1); //오름차순 (cf. 내림차순 : 0)
					var cell_num = row.insertCell(0);
					var cell_name = row.insertCell(1);
					var cell_tel = row.insertCell(2);
					
					cell_num.appendChild(atag);
					cell_name.appendChild(txt_name);
					cell_tel.appendChild(txt_tel);
				}
			}
		};
		
		xhr.open("get", "getListServlet", true);
		xhr.send();
	}

	
//회원 목록 조회(이름으로 조회)

	var txt_search = document.querySelector("input[name='search']");
	
	var btn_searchlist = document.querySelector("#btn_searchlist");
	btn_searchlist.addEventListener("click", searchProcess);
	
	function searchProcess(){
		
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			var tbl = document.querySelector("#tbl");
			tbl.innerHTML = "<thead><tr><td>번호</td><td>이름</td><td>전화번호</td></tr></thead>";
			
			if(xhr.readyState == 4 && xhr.status == 200){
				
				var jsonArray = xhr.responseText;
				var jobjList = JSON.parse(jsonArray);
				
				for(var i = 0; i < jobjList.length; i++){
					var txt_num = document.createTextNode(jobjList[i].num);
					var txt_name = document.createTextNode(jobjList[i].name);
					var txt_tel = document.createTextNode(jobjList[i].tel);
					var atag = document.createElement("a");
					atag.setAttribute("href", jobjList[i].num);
					atag.appendChild(txt_num);
					var row = tbl.insertRow(-1); //기준행 아래에 삽입 (cf. 기준행 위로 삽입 : 0)
					var cell_num = row.insertCell(0);
					var cell_name = row.insertCell(1);
					var cell_tel = row.insertCell(2);
					
					cell_num.appendChild(atag);
					cell_name.appendChild(txt_name);
					cell_tel.appendChild(txt_tel);
				}
			}
		};
		
		xhr.open("get", "getListServlet2?keyword="+ txt_search.value, true);
		xhr.send();
	}
	
</script>
</body>
</html>