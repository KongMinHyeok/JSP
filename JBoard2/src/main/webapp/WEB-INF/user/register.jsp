<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<!-- <script src="/JBoard2/js/validation.js"></script> -->
<script>
	
	let regPass = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	let regUid   = /^[a-z]+[a-z0-9]{4,19}$/g;
	let regName  = /^[가-힣]{2,4}$/;
	let regNick  = /^[가-힣a-zA-Z0-9]+$/;
	let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	let regHp	 = /^\d{3}-\d{3,4}-\d{4}$/;
	
	$(function(){
		
		$('#btnUidCheck').click(function(){
			
			let uid = $('input[name=uid]').val();
			
			$.ajax({
				url: '/JBoard2/user/checkUid.do',
				method: 'GET',
				data: {"uid":uid},
				dataType: 'json',
				success: function(data){
					
					if(data.result > 0){
						$('.uidResult').css('color', 'red').text('이미 사용중인 아이디 입니다');
					}else{
						$('.uidResult').css('color', 'green').text('사용 가능한 아이디 입니다');
					}
				}
			});
		});
		
		$('input[name=pass2]').focusout(function(){
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $(this).val();
			
			if(pass1 == pass2) {
				
				if(pass2.match(regPass)){
					$('.resultPw').css('color', 'green').text('비밀번호가 일치합니다');
				}else{
					$('.resultPw').css('color', 'red').text('영문, 숫자, 특수문자 조합이 5자 이상이어야 합니다');
				}
			}else{
				$('.resultPw').css('color', 'red').text('비밀번호가 일치하지 않습니다.');
			}
		});
		
		$('input[name=name]').focusout(function(){
			let name = $(this).val();
			
			if(!name.match(regName)){
				$('.resultName').css('color', 'red').text('이름이 2글자 이상 이어야 합니다');
			}else{
				$('.resultName').css('color', 'green').text('OK');
			}
		});
		
		$('#btnNick').click(function(){
			
			let nick = $('input[name=nick]').val();
			
			if(!nick.match(regNick)){
				$('resultNick').css('color', 'red').text('별명이 유효하지 않습니다');
				return;
			}			
			
		});	
	});
	
</script>
        <main id="user">
            <section class="register">
                <form action="/JBoard2/user/register.do" method="post">
                    <table border="1">
                        <caption>사이트 이용정보 입력</caption>
                        <tr>
                            <td>아이디</td>
                            <td>
                                <input type="text" name="uid" placeholder="아이디 입력"/>
                                <button type="button" id="btnUidCheck"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                                <span class="uidResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" name="pass1" placeholder="비밀번호 입력"/>
								<span class="resultPw"></span>
                            </td>
                            </tr>
                        <tr>
                            <td>비밀번호 확인</td>
                            <td><input type="password" name="pass2" placeholder="비밀번호 입력 확인"/></td>
                        </tr>
                    </table>

                    <table border="1">
                        <caption>개인정보 입력</caption>
                        <tr>
                            <td>이름</td>
                            <td>
                                <input type="text" name="name" placeholder="이름 입력"/> 
                                <span class="resultName"></span>                      
                            </td>
                        </tr>
                        <tr>
                            <td>별명</td>
                            <td>
                                <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                                <input type="text" name="nick" placeholder="별명 입력"/>
                                <button type="button" id="btnNick"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                                <span class="resultNick"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>
                                
                                <input type="email" name="email" placeholder="이메일 입력"/>
                                
                                <button type="button" id="btnEmail"><img src="../img/chk_auth.gif" alt="인증번호 받기"/></button>
                                <span class="resultEmail"></span>
                                <div class="auth">
                                    <input type="text" name="auth" placeholder="인증번호 입력"/>
                                    <button type="button" id="btnEmailConfirm"><img src="../img/chk_confirm.gif" alt="확인"/></button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>휴대폰</td>
                            <td><input type="text" name="hp" placeholder="휴대폰 입력"/></td>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td>
                                <input type="text" name="zip" placeholder="우편번호"/>
                                <button type="button"><img src="../img/chk_post.gif" alt="우편번호찾기"/></button>
                                <input type="text" name="addr1" placeholder="주소 검색"/>
                                <input type="text" name="addr2" placeholder="상세주소 입력"/>
                            </td>
                        </tr>
                    </table>

                    <div>
                        <a href="./login.html" class="btn btnCancel">취소</a>
                        <input type="submit" value="회원가입" class="btn btnRegister"/>
                    </div>
                </form>
            </section>
        </main>
<jsp:include page="./_footer.jsp"/>