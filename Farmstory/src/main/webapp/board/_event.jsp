<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
        <div id="sub">
            <div><img src="../img/sub_top_tit5.png" alt="COMMUNITY"></div>
            <section class="cate4">
                <aside>
                    <img src="../img/sub_aside_cate4_tit.png" alt="커뮤니티"/>

                    <ul class="lnb">
                        <li class="<%= cate.equals("event") ? "on" : "off"%>"><a href="./list.jsp?group=community&cate=event">이벤트</a></li>
                    </ul>
                </aside>
                <article>
                    <nav>
                        <img src="/Farmstory/img/sub_nav_tit_cate4_<%= cate %>.png" alt="공지사항"/>
                        <p>
                            HOME > 이벤트 > <em>이벤트</em>
                        </p>
                    </nav>