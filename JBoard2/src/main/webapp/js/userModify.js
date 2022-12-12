/**
 * 
 */
 	$(function(){
		//정규표현식
		let regPass = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		let regName = /^[가-힣]{2,4}$/;
		let regNick = /[0-9]|[a-z]|[A-Z]|[가-힣]{2,10}/;
		let regMail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		let regHp = /^\d{3}-\d{3,4}-\d{4}$/;
		
		
		//유효성 검사
		let isPassOk 	= false;
		let isNameOk 	= true;
		let isNickOk 	= true;
		let isEmailOk	= true;
		let isEmailAuthOk = true;
		let isHpOk		= true;
		
		//비밀번호 체크
		$('input[name=pass1]').keydown(function(){
			isPassOk = false;
			$('.passResult').text('');
		});
		
		$('input[name=pass2]').focusout(function(){
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $(this).val();
			
			if(pass1 == pass2){
				if(pass2.match(regPass)){
					isPassOk = true;
					$('.passResult').css('color','green').text('비밀번호가 일치합니다.');
				}else{
					//유효성 검사
					isPassOk = false;
					$('.passResult').css('color','red').text('영문,숫자,특수문자 조합 최소 5자리 이상');
				}
			}else{
				isPassOk = false;
				$('.passResult').css('color','red').text('비밀번호가 일치하지 않습니다.');
			}
		});
		
		//비밀번호 변경
		$('.passModify').click(function(){
			if(isPassOk){
				let uid = $('input[name=uid]').val();
				let pass2 = $('input[name=pass2]').val();
				
				let jsonData = {
					'uid' : uid,
					'pass' : pass2
				};
				
				$.ajax({
					url : '/JBoard2/user/findPwChange.do',
					method : 'post',
					data : jsonData,
					dataType : 'json',
					success : function(data){
						console.log(data.result);
						if(data.result > 0){
							alert('비밀번호가 변경되었습니다.');
							$('input[name=pass1]').val('');
							$('input[name=pass2]').val('');
							$('.passResult').text('');
						}else{
							return;
						}
					}
				});
				
			}else{
				alert('변경할 비밀번호를 확인해주십시요.')
				return false;
			}
		});
		
		//이름 유효성 검사
		$('input[name=name]').keydown(function(){
			isNameOk = false;
			$('.nameResult').text('');
		});
		
		$('input[name=name]').focusout(function(){
			let name = $(this).val();
			if(!name.match(regName)){
				isNameOk = false;
				$(this).blur(); //alert 무한루프 방지
				alert('이름은 한글 2글자 이상이어야합니다.');
				$('.nameResult').css('color','red').text('X');
			}else{
				isNameOk = true;
				$('.nameResult').css('color','green').text('사용가능한 이름입니다.');
			}
		});
		
		//별명 중복체크
		$('input[name=nick]').keydown(function(){
			isNickOk = false;
		});
		
		$('#btnNickCheck').click(function(){
			let nick = $('input[name=nick]').val();
			
			if(isNickOk){
				return;
			}
			
			//유효성 검사
			if(!nick.match(regNick)){
				isNickOk = false;
				$(this).blur(); //alert 무한루프 방지
				$('.nickResult').css('color','red').text('유효하지 않은 별명입니다.');
				return;
			}
			
			setTimeout(function(){
				$.ajax({
					url:'/JBoard2/user/checkNick.do',
					method:'get',
					data:{"nick":nick},
					dataType:'json',
					success:function(data){
						console.log(data.result);
						if(data.result > 0){
							isNickOk = false;
							$('.nickResult').css('color','red').text('이미 사용중인 별명 입니다.');
						}else{
							isNickOk = true;
							$('.nickResult').css('color','green').text('사용 가능한 별명 입니다.');
						}
					}
				});
			},1000);
		});
		
		//이메일 유효성 검사
		$('input[name=email]').keydown(function(){
			isEmailOk = false;
			isEmailAuthOk = false;
		});
		$('input[name=email]').focusout(function(){
			let email = $(this).val();
			if(!email.match(regMail)){
				isEmailOk = false;
				$('.emailResult').css('color','red').text('유효하지 않은 이메일 입니다.');
				$('.auth').hide();
			}else{
				isEmailOk = true;
				$('.emailResult').text('');
			}
		});
	
		let receivedCode = 0;
	
		//이메일 인증
		$('#btnEmail').click(function(){
			//이메일 인증코드 발송
			let email = $('input[name=email]').val();
			
			if(email == ''){
				alert('이메일을 확인하세요.');
				return;
			}
			
			if(isEmailAuthOk){
				return;
			}
			isEmailAuthOk = true;
			
			$('.emailResult').css('color','black').text('인증코드 전송 중...');
			
			setTimeout(function(){
				$.ajax({
					url:'/JBoard2/user/emailAuth.do',
					method:'get',
					data:{"email":email},
					dataType:'json',
					success:function(data){
						if(data.status > 0){
							//메일전송 성공
							isEmailAuthOk = true;
							$('.emailResult').css('color','red').text('인증코드를 확인 후 입력하세요.');
							$('.auth').show();
							$(this).hide();
							receivedCode = data.code;
						}else{
							//메일전송 실패
							isEmailAuthOk = false;
							$('.emailResult').text('');
							alert('메일전송이 실패했습니다.\n다시 시도하시기 바랍니다.');
							$('.auth').hide();
						}
					}
				});
			}, 1000);
				
			//이메일 인증코드 확인
			$("#btnEmailConfirm").click(function(){
				let code = $('input[name=auth]').val();
				
				if(code == ''){
					alert('이메일 확인 후 인증코드를 입력하세요.');
				}
				if(code == receivedCode){
					alert('이메일이 인증 되었습니다.');
					$('.emailResult').css('color','green').text('이메일이 인증 되었습니다.');
					$('.auth').hide();
				}else{
					alert('인증코드가 틀립니다.')
				}
			});
		});
		
		//핸드폰 유효성 검사
		$('input[name=hp]').focusout(function(){
			let hp = $(this).val();
			if(!hp.match(regHp)){
				isHpOk = false;
				$('.hpResult').css('color','red').text('유효하지 않은 전화번호 입니다.');
			}else{
				isHpOk = true;
				$('.hpResult').text('');
			}
		});
		
		//폼 전송
		$('.register > form').submit(function(){
			if(!isNameOk){
				alert('이름을 확인하십시요.');
				$('input[name=name]').focus();
				return false;
			}	
			if(!isNickOk){
				alert('별명을 확인하십시요.');
				$('input[name=nick]').focus();
				return false;
			}	
			if(!isEmailOk){
				alert('이메일을 확인하십시요.');
				$('input[name=email]').focus();
				return false;
			}	
			if(!isEmailAuthOk){
				alert('이메일 인증을 확인하십시요.');
				$('input[name=email]').focus();
				return false;
			}	
			if(!isHpOk){
				alert('전화번호를 확인하십시요.');
				$('input[name=hp]').focus();
				return false;
			}
			
			return true;
		});
		
		//회원탈퇴
		$('.userDelete').click(function(){
			let delChk = confirm('정말로 탈퇴하시겠습니까?');
			
			if(delChk == 1){
				
				let uid = $('input[name=uid]').val();
				
				$.ajax({
					url : '/JBoard2/user/delete.do',
					method : 'post',
					data : {'uid' : uid},
					dataType : 'json',
					success : function(data){
						console.log(data.result);
						if(data.result > 0){
							alert('회원탈퇴가 정상처리되었습니다.');
							location.href = "/JBoard2/user/login.do";
						}
					}
				});
			}

		});
		
	});

	//주소
	function postcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('zip').value = data.zonecode;
	            document.getElementById("addr1").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("addr2").focus();
	        }
	    }).open();
	}