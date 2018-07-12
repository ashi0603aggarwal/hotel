<!-- Responsive table starts here -->
    <!-- For correct display on small screens you must add 'data-title' to each 'td' in your table -->
<div class="table-responsive-vertical shadow-z-1">
    <!-- Table starts here -->
    <table id="table" class="table table-hover table-mc-light-blue">
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Name</th>
            <th>Contact No</th>
            <th>CheckIn Date</th>
            <th>CheckOut Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${booking1}" var="b" >
            <tr>
                <td data-title="Booking Id">${b.id}</td>
                <td data-title="Name">${b.customerName}</td>
                <td data-title="Contact No">${b.customerPhNo}</td>
                <td data-title="CheckIn Date"><g:formatDate format="dd/MM/yyyy" date="${b.checkInDate}"/></td>
                <td data-title="CheckOut Date"><g:formatDate format="dd/MM/yyyy" date="${b.checkOutDate}"/></td>
                <td data-title="Status">${b.bookingStatus}</td>
                <g:if test="${b.bookingStatus == "Open"}">
                    <td data-title="Generate Bill/Checkout">
                        <g:link action="checkOut" id="${b.id}">Bill/Checkout</g:link>
                    </td>
                </g:if>
                <g:else>
                    <td data-title="Generate Bill/Checkout">
                        <g:link action="checkOut" id="${b.id}">View/Edit Bill</g:link>
                    </td>
                </g:else>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>