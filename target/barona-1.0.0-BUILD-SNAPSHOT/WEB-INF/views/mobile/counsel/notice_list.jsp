<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="content">
	<div class="sub pad sm">
		<h1><img src="${pageContext.request.contextPath }/resources/images/commons/tit_sub.jpg"/></h1>
		<h2>공지사항</h2>
		
		<div class="top-srh">
			<div class="search">
				<select name="searchType">
					<option value="t" <c:out value="${cri.searchType eq 't'?'selected':''}"/>>제목</option>
					<option value="c" <c:out value="${cri.searchType eq 'c'?'selected':''}"/>>내용</option>
					<option value="tc" <c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>제목, 내용</option>
				</select>
				<input type="text" name="keyword" value="${cri.keyword }" id="keyword" />	
				<a href="#" class="btn_search">검색</a>		
			</div>
		</div>
		<ul class="mobile-list">
			<c:choose>
				<c:when test="${empty noticeList }">
					<li><p class="empty">게시물이 없습니다.</p></li>
				</c:when>
				<c:otherwise>
					<c:forEach var="notice" items="${noticeList}">
						<li>
							<fmt:parseDate var="noticeRegdate" value="${notice.noticeRegdate }" pattern="yyyy-MM-dd" />
							<p class="regdate"><fmt:formatDate value="${noticeRegdate }" pattern="yyyy.MM.dd" /></p>
							<h3 class="title"><a href="notice_view.do${pageMaker.makeSearch(cri.page)}&no=${notice.noticeNo }">${notice.noticeTitle }</a></h3>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</ul>
		<c:if test="${not empty noticeList }">
			<div class="paging">
			  <ul>
			    <li>
			    <c:choose>
				<c:when test="${pageMaker.pprev }">
			      <a href="notice_list.do${pageMaker.makeSearch(1)}">
			         <img src="${pageContext.request.contextPath }/resources/images/commons/page_pprev.gif" />
			      </a>
				</c:when>
			    <c:otherwise>
			    	<img src="${pageContext.request.contextPath }/resources/images/commons/page_pprev.gif" />
			    </c:otherwise>
			    </c:choose>
			    </li>
			    <li style="margin-right: 6px;">
			    <c:choose>
			   	<c:when test="${pageMaker.prev }">
			   	  <a href="notice_list.do${pageMaker.makeSearch(pageMaker.startPage - 1) }">
			        <img src="${pageContext.request.contextPath }/resources/images/commons/page_prev.gif" />
			      </a>
			   	</c:when>
			   	<c:otherwise>
			   		<img src="${pageContext.request.contextPath }/resources/images/commons/page_prev.gif" />
			   	</c:otherwise>
			    </c:choose>
			    </li>
			    
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage }" var="idx">
					<li class="page_no 
						<c:out value="${pageMaker.cri.page == idx?' active':''}"/>">
						<a href="notice_list.do${pageMaker.makeSearch(idx) }">${idx}</a>
					</li>
				</c:forEach>
							
			    <li style="margin-left: 6px;">
			    <c:choose>
			    <c:when test="${pageMaker.next}">
			      <a href="notice_list.do${pageMaker.makeSearch(pageMaker.endPage + 1) }">
			        <img src="${pageContext.request.contextPath }/resources/images/commons/page_next.gif" />
			      </a>
			    </c:when>
			    <c:otherwise>
			    	<img src="${pageContext.request.contextPath }/resources/images/commons/page_next.gif" />
			    </c:otherwise>
			    </c:choose>
			    </li>
			    <li>
			    <c:choose>
			    <c:when test="${pageMaker.nnext}">
			      <fmt:parseNumber var="page_nnext" integerOnly="true" value="${(pageMaker.totalCount / pageMaker.cri.perPageNum) + (pageMaker.totalCount % pageMaker.cri.perPageNum == 0 ? 0 : 1)}"/>
			      <a href="notice_list.do?page=${page_nnext }&perPageNum=${pageMaker.cri.perPageNum }&searchType=${pageMaker.cri.searchType }&keyword=${pageMaker.cri.keyword }">
			        <img src="${pageContext.request.contextPath }/resources/images/commons/page_nnext.gif" />
			      </a>
			    </c:when>
			    <c:otherwise>
			        <img src="${pageContext.request.contextPath }/resources/images/commons/page_nnext.gif" />
			    </c:otherwise>
			    </c:choose>
			    </li>
			  </ul>
			</div>
		</c:if>
		<script>
			$('.btn_search').on( "click", function(event) {
				event.preventDefault();
				self.location = "notice_list.do"
						+ '${pageMaker.makeQuery(1)}'
						+ "&searchType="
						+ $("select[name='searchType'] option:selected").val()
						+ "&keyword=" + $('#keyword').val();
			});		
		</script>
	</div>
</div>
