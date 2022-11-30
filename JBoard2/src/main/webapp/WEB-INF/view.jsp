<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script type="text/javascript" charset="UTF-8">
$(document).ready(function() {
	
	// 댓글 삭제하기
	$(document).on('click','.delete',function(e){
		e.preventDefault();
		
		let article = $(this).closest('article');
		let result = confirm('정말 삭제 하시겠습니까?');
		
		if(result){
			let no = $(this).attr('data-no');
			let parent = $(this).attr('data-parent');
			
			let jsonData = {
					"no":no,
					"parent":parent
			};
			
			$.ajax({
				url:'/JBoard2/commentDelete.do',
				type:'GET',
				data:jsonData,
				dataType:'json',
				success:function(data){
					
					if(data.result > 0){
						alert('댓글 삭제 완료!');
						article.hide();
						
					}
				}
			});
		}
	});
	
	// 댓글 수정하기
	$(document).on('click','.modify',function(e){
		e.preventDefault();
		
		let txt = $(this).text();
		let p = $(this).parent().prev();
		if(txt=="수정"){
			// 수정모드
			$(this).text('수정완료');
			p.attr('contentEditable',true);
			p.focus();
		}else{
			// 수정완료
			$(this).text('수정');
			p.attr('contentEditable',false);
			
			let no = $(this).attr('data-no');
			let content = p.text();
			
			let jsonData = {
					"content":content,
					"no":no
			};
			
			$.ajax({
				url:'/JBoard2/commentModify.do',
				type:'POST',
				data:jsonData,
				dataType:'json',
				success:function(data){
					
					if(data.result > 0){
						alert('댓글 수정 완료!');
					}
					
				}
			});
		}
		
		
	});
	
	// 댓글 쓰기
	
	$('.commentForm > form').submit(function() {
		
		let pg = $(this).children('input[name=pg]').val();
		let parent = $(this).children('input[name=parent]').val();
		let content = $(this).children('textarea[name=content]').val();
		let uid = $(this).children('input[name=uid]').val();
		
		let jsonData = ({
			"pg":pg,
			"parent":parent,
			"content":content,
			"uid":uid
		});
		
		console.log(jsonData);
		
		$.ajax({
			url:'/JBoard2/commentWrite.do',
			method:'post',
			data:jsonData,
			dataType:'json',
			success:function(data){
				
				console.log(data);
				
				let article = "<article class='comment'>";
					article += "<span class='nick'>"+data.nick+"</span>&nbsp;";
					article += "<span class='date'>"+data.date+"</span>";
					article += "<p class='comment'>"+data.content+"</p>";
					article += "<div>";
					article += "<a href='#' class='delete' data-no='"+data.no+"'>삭제</a>&nbsp;";
					article += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";
					article += "</div>";
					article += "</article>";
				
				$('.commentList > .empty').hide();
				$('.commentList').append(article);
				$('textarea[name=content]').val('');
				
			}
		});
		
		return false;
	});
});
</script>
        <main id="board">
            <section class="view">
                <table>
                	<caption>글보기</caption>
                   <tr>
                       <th>제목</th>
                       <td><input type="text" name="title" value="${article.title }" readonly></td>
                   </tr>
                   <c:if test="${article.file > 0}">
                   <tr>
                       <th>첨부파일</th>
                       <td>
                           <a href="/JBoard2/download.do?fno=${article.fno }">${article.oriName}</a>
                            <span>${article.download}</span>회 다운로드
                       </td>
                   </tr>
                   </c:if>
                   <tr>
                       <th>내용</th>
                       <td>
                           <div>${article.content }</div>
                       </td>
                   </tr>
                </table>
                
                <div class="send">
               		<c:if test="${sessUser.uid.equals(article.uid)}">
                   <a href="/JBoard2/delete.do?no=${article.no }&pg=${pg }" class="btn btnDelete">삭제</a>
                   <a href="/JBoard2/modify.do?no=${article.no }&pg=${pg }" class="btn btnModify">수정</a>
                   </c:if>
                   <a href="/JBoard2/list.do?pg=${pg}" class="btn btnList">목록</a>
                </div>

                <!-- 댓글목록 -->
                <section class="commentList">
                   <h3>댓글목록</h3>
                <c:forEach var="comment" items="${comments}">
                <article class="comment">
                    <span class="nick">${comment.nick}</span>
                    <span class="date">${comment.rdate}</span>
                    <p class="comment">${comment.content}</p>
                    <div>
                    	<c:if test="${sessUser.uid.equals(article.uid)}">
                        <a href="#" class="delete" data-no="${comment.no}" data-parent="${comment.parent}">삭제</a>
                        <a href="#" class="modify" data-no="${comment.no}">수정</a>
                        </c:if>
                    </div>
                </article>
                </c:forEach>
                <c:if test="${comments.size()==0}">
                <p class="empty">등록된 댓글이 없습니다.</p>
                </c:if>
                </section>

                <!-- 댓글쓰기 -->
                <section class="commentForm">
                    <h3>댓글쓰기</h3>
                	<form action="#" method="post">
	                	<input type="hidden" name="pg" value="${pg }">
	                	<input type="hidden" name="parent" value="${no }">
	                	<input type="hidden" name="uid" value="${sessUser.uid }">
	                    <textarea name="content" placeholder="댓글내용 입력"></textarea>
	                    <div>
	                        <a href="#" class="btn btnCancel">취소</a>
	                        <input type="submit" class="btn btnComplete" value="작성완료">
	                    </div>
                	</form>
                </section>

            </section>
        </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>