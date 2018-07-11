<%--
  Created by IntelliJ IDEA.
  User: ROMI
  Date: 5/28/2018
  Time: 5:29 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:stylesheet src="booking/roomSelection.css"/>
    <title></title>
</head>

<body>
<div >
    <div class="cockpit">
        <h1>Room availability </h1>
    </div>

    <ol class="cabin fuselage">
        <g:form action="submitForm">
            <g:each in="${1..r}" var="ro">
                <li class="row">
                    <ol class="seats" type="A">
                        <g:each in="${1..10}" var="c">
                            <g:set var="room" value="${hotelRoomsList.get((10*(ro-1))+(c-1))}"/>
                            <g:set var="disabled" value=""/>
                            <g:if test="${room.availability=="No"}">
                                <g:set var="disabled" value="disabled"/>
                            </g:if>
                            <li class="seat">
                                <input type="checkbox" name="check" ${disabled} id="${room.roomNo}" value="${room.roomNo}" />
                                <label for="${room.roomNo}">${room.roomNo}</label>
                            </li>
                        </g:each>
                    </ol>
                </li>
            </g:each>
            <g:hiddenField name="customerName" value="${p.customerName}"/>
            <g:hiddenField name="customerEmail" value="${p.customerEmail}"/>
            <g:hiddenField name="customerAddress" value="${p.customerAddress}"/>
            <g:hiddenField name="customerPhNo" value="${p.customerPhNo}"/>
            <g:hiddenField name="checkInDate" value="${p.checkInDate}"/>
            <g:hiddenField name="checkInTime" value="${p.checkInTime}"/>
            <g:hiddenField name="noOfPerson" value="${p.noOfPerson}"/>
            <g:hiddenField name="bookedBy" value="${p.bookedBy}"/>
            <g:hiddenField name="blockedBy" value="${p.blockedBy}"/>
            <g:hiddenField name="oyo" value="${p.oyo}"/>
            <g:hiddenField name="cash" value="${p.cash}"/>
            <g:hiddenField name="paytm" value="${p.paytm}"/>
            <g:actionSubmit value="Submit" action="submitForm"/>
        </g:form>
    </ol>
</div>


</body>
</html>