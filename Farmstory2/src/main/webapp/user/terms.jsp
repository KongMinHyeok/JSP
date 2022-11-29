<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
        <main id="user" class="terms">
            <table border="0">
                <caption>사이트 이용약관</caption>
                <tr>
                    <td>
                        <textarea class="terms" readonly>${vo.terms}</textarea>
                        <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
                    </td>
                </tr>
            </table>

            <table border="0">
                <caption>개인정보 취급방침</caption>
                <tr>
                    <td>
                        <textarea class="privacy" readonly>${vo.privacy}</textarea>
                        <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
                    </td>
                </tr>
            </table>

            <p>
                <a href="/Farmstory2/user/login.do" class="cancel">취소</a>
                <a href="/Farmstory2/user/register.do" class="next">다음</a>
            </p>

        </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>