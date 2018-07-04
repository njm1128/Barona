<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="content">
	<div class="sub pad sm wid_sm">
		<h2><img src="${pageContext.request.contextPath }/resources/images/counsel/tit_faq.jpg" style="width: 70px;"/></h2>
		
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
		<form action="register.do" method="post" name="frm_reg">
			<input type="hidden" name="faqNo" value="0" />
			<input type="hidden" name="menu_code" value="${menu_code }" />
			<ul class="mobile-list" id="regFrm" style="display: none;">
				<li>
					<table class="faq">
						<tbody><tr>
							<td class="info que" width="13%"><span>질문</span></td>
							<td class="type" width="25%"><input type="text" name="faqType" placeholder="질문 유형" style="width: 100%;"></td>
							<td class="question" width="50%"><input type="text" name="faqQuestion" placeholder="질문" style="width: 100%;"></td>
						</tr>
					</tbody></table>
				</li>
				<li style="border: none;">
					<table class="faq">
						<tbody><tr>
							<td class="info ans" width="13%"><span>답변</span></td>
							<td class="answer" width="*"><textarea name="faqAnswer" placeholder="답변" style="width: 100%; min-height: 90px;"></textarea></td>
						</tr>
					</tbody></table>
				</li>
				<li style="text-align: center; border: none;">
					<button class="btn_big" type="button" onclick="javascript:reg_submit()" id="btnReg">등록하기</button>
				</li>
			</ul>
		</form>
		<ul class="mobile-list">
			<c:choose>
				<c:when test="${empty faqList }">
					<li><p class="empty">등록된 질문이 없습니다.</p></li>
				</c:when>
				<c:otherwise>
					<c:forEach var="faq" items="${faqList}" varStatus="status">
						<li>
							<table class="faq">
								<tr>
									<td class="info que" width="13%"><span>질문</span></td>
									<td class="type" width="20%">${faq.faqType}</td>
									<td class="question" width="*"><a href="javascript:show_answer('${status.count}')">${faq.faqQuestion}</a></td>
									<td width="10%">
										<button class="btn_sm" type="button" onclick="javascript:modify('${faq.faqNo}', '${faq.faqType}', '${faq.faqQuestion}', '${faq.faqAnswer}')">수정</button>
										<button class="btn_sm" type="button" onclick="javascript:remove('${faq.faqNo}')">삭제</button>
									</td>
								</tr>
							</table>
						</li>
						<li id="answer${status.count}" style="display: none;">
							<table class="faq">
								<tr>
									<td class="info ans" width="13%"><span>답변</span></td>
									<td class="answer" width="*">${faq.faqAnswer}</td>
								</tr>
							</table>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</ul>
		
		<div style="text-align: right; margin: 15px 0 0;">
			<button class="btn_list" id="register" onclick="javascript:register()">등록</button>
		</div>
		
		<c:if test="${not empty faqList }">
			<div class="paging">
			  <ul>
			    <li>
			    <c:choose>
				<c:when test="${pageMaker.pprev }">
			      <a href="list.do${pageMaker.makeSearch(1)}&menu_code=${menu_code}">
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
			   	  <a href="list.do${pageMaker.makeSearch(pageMaker.startPage - 1) }&menu_code=${menu_code}">
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
						<a href="list.do${pageMaker.makeSearch(idx) }&menu_code=${menu_code}">${idx}</a>
					</li>
				</c:forEach>
							
			    <li style="margin-left: 6px;">
			    <c:choose>
			    <c:when test="${pageMaker.next}">
			      <a href="list.do${pageMaker.makeSearch(pageMaker.endPage + 1) }&menu_code=${menu_code}">
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
			      <a href="list.do?page=${page_nnext }&perPageNum=${pageMaker.cri.perPageNum }&searchType=${pageMaker.cri.searchType }&keyword=${pageMaker.cri.keyword }&menu_code=${menu_code}">
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
		
		<form method="get" name="frm_param">
			<input type="hidden" name="no" />
			<input type="hidden" name="page" value="${cri.page }" />
			<input type="hidden" name="perPageNum" value="${cri.perPageNum }" />
			<input type="hidden" name="searchType" value="${cri.searchType }" />
			<input type="hidden" name="keyword" value="${cri.keyword }" />
			<input type="hidden" name="menu_code" value="${menu_code }" />
		</form>
		
		<script>
			$('.btn_search').on( "click", function(event) {
				event.preventDefault();
				self.location = "list.do"
						+ '${pageMaker.makeQuery(1)}'
						+ "&searchType="
						+ $("select[name='searchType'] option:selected").val()
						+ "&keyword=" + $('#keyword').val()
						+ "&menu_code=${menu_code}";
			});		
			
			function show_answer(idx) {
				var answer = $('#answer' + idx);
				answer.toggleClass('on');
				if(answer.hasClass('on')) {
					answer.show();
				} else {
					answer.hide();
				}
			}
			
			function register() {
				var form = document.frm_reg;
				form.faqNo.value = 0;
				form.faqType.value = '';
				form.faqQuestion.value = '';
				form.faqAnswer.value = '';
				
				if($('#btnReg').text() == '수정하기') {
					$('#btnReg').text('등록하기');
					$('#regFrm').show();
				} else {
					$('#regFrm').toggle();
				}
			}
			
			function reg_submit() {
				var form = document.frm_reg;
				if(form.faqType.value == '') {
					alert('질문 유형을 입력해주세요.');
					form.faqType.focus();
					return false;
				} else if (form.faqQuestion.value == '') {
					alert('질문을 입력해주세요.');
					form.faqQuestion.focus();
					return false;
				} else if (form.faqAnswer.value == '') {
					alert('답변을 입력해주세요.');
					form.faqAnswer.focus();
					return false;
				}
				if($('#btnReg').text() == '등록하기') {
					form.action = "register.do";
				} else {
					form.action = "modify.do";
				}
				form.submit();
			}
			
			function modify(no, type, question, answer) {
				var form = document.frm_reg;
				form.faqNo.value = no;
				form.faqType.value = type;
				form.faqQuestion.value = question;
				form.faqAnswer.value = answer;
				$('#btnReg').text('수정하기');
				$('#regFrm').show();
			}
			
			function remove(no) {
				var form = document.frm_param;
				var result = confirm('이 질문을 삭제하시겠습니까 ?');
				if(result) {
					form.no.value = no;
					form.action = "remove.do";
					form.method = "post";
					form.submit();
				}
			}
		</script>
	</div>
</div>