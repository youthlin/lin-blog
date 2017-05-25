<%@ taglib prefix="g" uri="http://youthlin.com/linblog/tag/comment" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="static com.youthlin.utils.i18n.Translation.__" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 17-5-6
  Time: 下午9:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/pages/common/admin/header.jsp" %>
<script>$(document).ready(function () {
    $(".menu-parent-comment").addClass("active").click();
    $(".menu-item-comment").addClass("active");
    $('#a-${status}').css('font-weight', 'bold').css('color', '#000').addClass("btn-info");
});</script>
<%--@elvariable id="status" type="java.lang.String"--%>
<%--@elvariable id="allCount" type="java.lang.String"--%>
<%--@elvariable id="PENDING" type="java.lang.String"--%>
<%--@elvariable id="NORMAL" type="java.lang.String"--%>
<%--@elvariable id="SPAM" type="java.lang.String"--%>
<%--@elvariable id="TRASH" type="java.lang.String"--%>
<h1><%=__("All Comments")%></h1>
<div class="status-selector margin-top-bottom-p1">
    <div class="btn-group" role="group" aria-label="post status">
        <a class="btn btn-default" id="a-all" href="<c:url value="/admin/comment"/>">
            <%=__("All")%><span class="badge">${allCount}</span></a>
        <a class="btn btn-default" id="a-pending" href="<c:url value="/admin/comment/pending"/>">
            <%=__("Pending")%><span class="badge">${PENDING}</span></a>
        <a class="btn btn-default" id="a-normal" href="<c:url value="/admin/comment/normal"/>">
            <%=__("Approved")%><span class="badge">${NORMAL}</span></a>
        <a class="btn btn-default" id="a-spam" href="<c:url value="/admin/comment/spam"/>">
            <%=__("Spam")%><span class="badge">${SPAM}</span></a>
        <a class="btn btn-default" id="a-trash" href="<c:url value="/admin/comment/trash"/>">
            <%=__("Trash")%><span class="badge">${TRASH}</span></a>
    </div>
</div>
<div class="table-responsive">
    <table class="table table-striped table-hover border-ccc">
        <thead>
        <tr>
            <th>
                <label class="no-bottom-margin">
                    <span class="sr-only"><%=__("Select All")%></span>
                    <input type="checkbox">
                </label>
            </th>
            <th><%=__("Author")%></th>
            <th><%=__("Comment")%></th>
            <th><%=__("Post")%></th>
            <th><%=__("Date")%></th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <%--@elvariable id="commentPage" type="com.youthlin.blog.model.bo.Page"--%>
            <c:when test="${not empty commentPage}">
                <%--@elvariable id="comment" type="com.youthlin.blog.model.po.Comment"--%>
                <c:forEach items="${commentPage.list}" var="comment">
                    <c:set var="trClass" value=""/>
                    <c:choose>
                        <c:when test="${comment.commentStatus.code eq 1}">
                            <c:set var="trClass" value="warning"/>
                        </c:when>
                        <c:when test="${comment.commentStatus.code eq 2}">
                            <c:set var="trClass" value="danger"/>
                        </c:when>
                        <c:when test="${comment.commentStatus.code eq 3}">
                            <c:set var="trClass" value="danger"/>
                        </c:when>
                    </c:choose>
                    <tr class="${trClass}">
                         <td>
                             <label><span class="sr-only"><%=__("Select")%></span>
                            <input type="checkbox" name="ids" value="${comment.commentId}"></label>
                         </td>
                        <td>
                            <img src="${g:img(comment.commentAuthorEmail)}" alt="Avatar" height="40" width="40">
                            <span class="comment-info comment-info-author">${comment.commentAuthor}</span><br>
                            <span class="comment-info comment-info-url">${comment.commentAuthorUrl}</span><br>
                            <span class="comment-info comment-info-email">${comment.commentAuthorEmail}</span><br>
                            <span class="comment-info comment-info-ip">${comment.commentAuthorIp}</span><br>
                        </td>
                        <td class="relative">
                            <div class="comment-info comment-info-content">${comment.commentContent}</div>
                            <div class="comment-info comment-info-action absolute-bottom">
                                <a href="#"><%=__("Edit")%></a>
                                | <a href="<c:url value="/post/${comment.commentPostId}#comment-${comment.commentId}"/>"
                                     target="_blank"><%=__("View")%></a>
                                    <%--0正常 1待审 2垃圾 3删除--%>
                                    <c:if test="${comment.commentStatus.code ne 0}">
                                        | <a href="?action=normal&id=${comment.commentId}" class="text-info">
                                            <%=__("approved")%></a>
                                    </c:if>
                                    <c:if test="${comment.commentStatus.code ne 1}">
                                        | <a href="?action=pending&id=${comment.commentId}" class="text-warning">
                                            <%=__("unapproved")%></a>
                                    </c:if>
                                    <c:if test="${comment.commentStatus.code ne 2}">
                                        |<a href="?action=spam&id=${comment.commentId}" class="text-danger">
                                        <%=__("Tag as spam")%></a>
                                    </c:if>
                                    <c:if test="${comment.commentStatus.code ne 3}">
                                        | <a href="?action=trash&id=${comment.commentId}" class="text-danger">
                                    <%=__("Move to trash")%></a>
                                    </c:if>

                            </div>
                        </td>
                        <td>
                            <%--@elvariable id="postMap" type="java.util.Map"--%>
                            <%--@elvariable id="post" type="com.youthlin.blog.model.po.Post"--%>
                            <a href="<c:url value="/post/${comment.commentPostId}"/>" target="_blank">
                                <c:set var="post" value="${postMap[comment.commentPostId]}"/>
                                ${post.postTitle}
                            </a>
                        </td>
                        <td><fmt:formatDate value="${comment.commentDate}" pattern="YYYY-MM-dd HH:mm"/></td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr><td colspan="5"><%=__("No comments")%></td></tr>
            </c:otherwise>
        </c:choose>

        </tbody>
    </table>
</div>
<%@ include file="/WEB-INF/pages/common/admin/footer.jsp" %>
