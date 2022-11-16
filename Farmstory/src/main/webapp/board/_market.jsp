<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
        <div id="sub">
            <div><img src="/Farmstory/img/sub_top_tit5.png" alt="COMMUNITY"></div>
            <section class="cate2">
                <aside>
                    <img src="/Farmstory/img/sub_aside_cate2_tit.png" alt="커뮤니티"/>

                    <ul class="lnb">
                        <li class="<%= cate.equals("market") ? "on" : "off"%>"><a href="./list.jsp?group=community&cate=market">장보기</a></li>
                    </ul>

                </aside>
                <article>
                    <nav>
                        <img src="/Farmstory/img/sub_nav_tit_cate2_<%= cate %>.png" alt="장보기"/>
                        <p>
                            HOME > 장보기 > <em>장보기</em>
                        </p>
                    </nav>