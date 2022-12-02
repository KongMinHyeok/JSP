<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script>

	let regUid   = /^[a-z]+[a-z0-9]{4,19}$/g;
	let regName  = /^[가-힣]{2,4}$/;
	let regNick  = /^[가-힣a-zA-Z0-9]+$/;
	let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	let regHp	 = /^\d{3}-\d{3,4}-\d{4}$/;
	let regPass  = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	
	let receivedCode = 0;
	
	$(function(){
		
		$('#btnUidCheck').click(function(){
			
			let uid = $('input[name=uid]').val();
			
			if(!uid.match(regUid)){
				$('.resultUid').css('color', 'red').text('아이디가 유효하지 않습니다.');	
			}
			console.log('here3');
			
			let jsonData = {"uid":uid};
			
			$('.resultUid').css('color', 'black').text('...');
			console.log('here4');
			setTimeout(()=>{
		
				$.ajax({
					url:'/Farmstory2/user/checkUid.do',
					method: 'get',
					data: jsonData,
					dataType: 'json',
					success:function(data){
						console.log('here5');
						if(data.result == 0){
							$('.resultUid').css('color', 'green').text('사용 가능한 아이디 입니다.');
						}else{
							$('.resultUid').css('color', 'red').text('이미 사용중인 아이디 입니다.');
						}
					}
				});
			}, 500);
		});
		
		$('input[name=pass2]').focusout(function(){
			
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $(this).val();
			
			if(pass1 == pass2) {
				
				if(pass2.match(regPass)){
					$('.resultPass').css('color', 'green').text('비밀번호가 일치합니다');
				}else{
					$('.resultPass').css('color', 'red').text('영문, 숫자, 특수문자 조합 최소 5자 이상이어야 합니다');
				}
			}else{
				$('.resultPass').css('color', 'red').text('비밀번호가 일치하지 않습니다');
			}
			
		});
		
		
		$('input[name=name]').focusout(function(){
		
			let name = $(this).val();
			
			if(!name.match(regName)){
				$('.resultName').css('color', 'red').text('이름은 한글 2글자 이상이어야 합니다.');
			}else {
				$('.resultName').css('color', 'green').text('사용가능한 이름 입니다.');
			}
			
		});
		
		$('#btnNick').click(function(){
			
			let nick = $('input[name=nick]').val();
			
			if(!nick.match(regNick)){
				$('.resultNick').css('color', 'red').text('별명이 유효하지 않습니다.');
				return;
			}
			
			let jsonData = {"nick":nick};
			
			$('.resultNick').css('color', 'black').text('...')
			
			setTimeout(()=>{
				
				$.ajax({
					url:'/Farmstory2/user/checkNick.do',
					type:'get',
					data:jsonData,
					dataType:'json',
					success:function(data){
						
						if(data.result == 1){
							$('.resultNick').css('color', 'red').text('이미 사용중인 닉네임 입니다.');
						}else{
							$('.resultNick').css('color', 'green').text('시용 가능한 닉네임입니다.');
						}
					}
					
				});
				
			}, 500);
		});
		
		$('input[name=email]').focusout(function(){
			
			let email = $(this).val();
			
			if(!email.match(regEmail)){
				$('.resultEmail').css('color', 'red').text('이메일이 유효하지 않습니다.');
			}else{
				$('.resultEmail').css('color', 'green').text('사용 가능한 이메일 입니다.');
			}
		});
	
		$('#btnEmail').click(function(){
			
			$(this).hide();
			let email = $('input[name=email]').val();
			
			if(email == ''){
				alert('이메일을 입력하세요');
			}
			
			$('.resultEmail').css('color', 'black').text('이메일 인증코드 전송 중입니다. 잠시만 기다려 주세요.');
			
			
			setTimeout(function(){
				
				$.ajax({
					url:'/Farmstory2/user/EmailAuth.do',
					type:'GET',
					data: {"email":email},
					dataType:'json',
					success:function(data){
						
						if(data.status > 0){
							$('.resultEmail').text('메일 발송이 완료되었습니다.\n인증코드 입력하세요');
							$('.auth').show();
							receivedCode = data.code;
						}else{
							$('.resultEmail').css('color', 'red').text('메일 발송이 실패 했습니다.\n다시 시도 하시기 바랍니다.')
						}
						
					}
				});
				
			}, 1000);
			
		});
		
		$('btnEmail').click(function(){
			
			$('#btnEmailConfirm').click(function(){
				
				let code = $('input[name=auth]').val();
				
				if(code == '') {
					alert('이메일을 확인 후 인증코드를 입력하세요.');
					return;
				}
				
				if(code == receivedCode){
					$('iuput[name=email]').attr('readonly', true);
					$('.resultEmail').text('이메일이 인증 되었습니다.');
					$('.auth').hide();
				}else{
					alert('인증코드가 틀립니다.\n다시 확인 하십시오.');
				}
				
			});
		});
	});

</script>
        <main id="user" class="register">
            <form action="#">
                <table border="1">
                    <caption>사이트 이용정보 입력</caption>
                    <tr>
                        <th>아이디</th>
                        <td>
                            <input type="text" name="uid" placeholder="아이디 입력"/>
                            <button type="button" id="btnUidCheck"><img src="/Farmstory2/img/chk_id.gif" alt="중복확인"/></button>
                            <span class="resultUid"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>비밀번호</th>
                        <td>
                            <input type="password" name="pass1" placeholder="비밀번호 입력"/>
                            <span class="resultPass"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>비밀번호 확인</th>
                        <td>
                            <input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
                        </td>
                    </tr>
                </table>

                <table border="1">
                    <caption>개인정보 입력</caption>
                    <tr>
                        <th>이름</th>
                        <td>
                            <input type="text" name="name" placeholder="이름 입력"/>
                            <span class="resultName"></span>                
                        </td>
                    </tr>
                    <tr>
                        <th>별명</th>
                        <td>
                            <p>공백없이 한글, 영문, 숫자 입력</p>
                            <input type="text" name="nick" placeholder="별명 입력"/>
                            <button type="button" id="btnNick"><img src="/Farmstory2/img/chk_id.gif" alt="중복확인"/></button>
                            <span class="resultNick"></span>
                        </td>
                    </tr>                    
                    <tr>
                        <th>이메일</th>
                        <td>
                            <input type="email" name="email" placeholder="이메일 입력"/>
                            <span class="resultEmail"></span>
                            <button type="button" id="btnEmail"><img src="/Farmstory2/img/chk_auth.gif" alt="인증번호"/></button>
                            <div class="auth">
                            	<input type="text" name="auth" placeholder="인증번호 입력"/>
                            	<button type="button" id="btnEmailConfirm"><img src="../img/chk_confirm.gif" alt="확인"/></button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>휴대폰</th>
                        <td>
                            <input type="text" name="hp" placeholder="- 포함 13자리 입력"/>
                        </td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>
                            <input type="text" name="zip" placeholder="우편번호 검색" readonly/>
                            <button type="button"><img src="/Farmstory2/img/chk_post.gif" alt="우편번호 찾기"/></button>
                            <input type="text" name="addr1" placeholder="기본주소 검색" readonly/>
                            <input type="text" name="addr2" placeholder="상세주소 입력"/>
                        </td>
                    </tr>
                </table>
                <div>
                    <a href="./login.jsp" class="btnCancel">취소</a>
                    <input type="submit" class="btnRegister" value="회원가입"/>
                </div>
            </form>            
        </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>