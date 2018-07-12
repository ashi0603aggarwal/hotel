<%@ page contentType="text/html;charset=UTF-8" %>
<asset:javascript src="application.js"></asset:javascript>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Invoice</title>
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <asset:stylesheet src="d.css"></asset:stylesheet>
    <asset:stylesheet src="Booking/book.css"></asset:stylesheet>
    <asset:javascript src="Validate_Js.js"></asset:javascript>
    <link rel="license" href="https://www.opensource.org/licenses/mit-license/">

</head>
<body class="bg">
<header>
    <h1>Invoice</h1>
    <address>
        <p>${hr.hotelName}, Address: ${hr.address}, Ph No: </p>
        <p>GST No: ${hr.gstin}
        <p>License No: ${hotelDetails.hotelLicenceNo}, Food License No: ${hotelDetails.foodLicenceNo}</p>
    </address>
    <span style="width: 5%; height: 5%"><img alt="" src="data:image/png;base64",${hotelDetails.logo.encodeBase64()}></span>
</header>
<article>
    <div>
        <div class="row">
            <div class="col-lg-3" style="padding: 0px;">
                <table class="">
                    <tr>
                        <th><span>Invoice #</span></th>
                        <td><span>${booking.billGeneration.billNo}</span></td>
                    </tr>
                    <tr>
                        <th><span>Invoice Date</span></th>
                        <td>
                            <span><g:formatDate format="dd/MM/yyyy" date="${booking.billGeneration.invoiceDate}"></g:formatDate></span>
                        </td>
                    </tr>
                    <tr style="visibility: hidden">
                        <th><span>Amount Due</span></th>
                        <td><span id="prefix">Rs.</span><span>600.00</span></td>
                    </tr>
                </table>
            </div>
            <div class="col-lg-3" style="padding: 0px">
                <table class="">
                    <tr>
                        <th><span>Guest Name</span></th>
                        <td><span>${booking.customerName}</span></td>
                    </tr>
                    <tr>
                        <th><span>Address</span></th>
                        <td><span>${booking.customerAddress}</span></td>
                    </tr>
                    <tr>
                        <th><span>Phone No</span></th>
                        <td><span >${booking.customerPhNo}</span></td>

                    </tr>
                    <tr>
                        <th><span>GST</span></th>
                        <td><span >${booking?.billGeneration?.customerGst}</span></td>

                    </tr>
                </table>
            </div>
            <div class="col-lg-6" style="padding: 0px">
                <table class="">
                    <tr>
                        <th><span>Check In Date</span></th>
                        <td>
                            <span><g:formatDate format="dd/MM/yyyy" date="${booking.checkInDate}"></g:formatDate></span>
                        </td>
                    </tr>
                    <tr>
                        <th><span>Check In Time</span></th>
                        <td>
                            <span><g:formatDate format="HH:mm aa" date="${booking.checkInTime}"/></span>
                        </td>
                    </tr>
                    <tr>
                        <th><span>Check Out Date</span></th>
                        <td>
                            <span><g:formatDate format="dd/MM/yyyy" date="${booking.checkOutDate}"></g:formatDate></span>
                        </td>
                    </tr>
                    <tr>
                        <th><span>Check Out Time</span></th>
                        <td>
                            <span><g:formatDate format="HH:mm aa" date="${booking.checkOutTime}"/></span>

                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <br>
    <table class="inventory">
        <thead>
        <tr>
            <th><span >Room No</span></th>
            <th><span >Room Rate</span></th>
            <th><span >No. Of Persons</span></th>
            <th><span >No. Of Days</span></th>
            <th><span >Tax</span></th>
            <th><span >Tax Rate</span></th>
            <th><span >Total</span></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${booking.billGeneration.roomDetails}" var="room">
            <tr>
                <td><a class="cut">-</a><span >${room.roomNo}</span></td>
                <td><span data-prefix>Rs.</span><span>${room.roomRate}</span></td>
                <td><span>${room.noOfPerson}</span></td>
                <td><span>${room.noOfDays}</span></td>
                <td><span data-prefix>Rs.</span><span >${room.tax}</span></td>
                <td><span >${room.taxRate}</span></td>
                <td><span data-prefix>Rs.</span><span>${room.total}</span></td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <table class="balance">
        <tr>
            <th><span>Other Charges</span></th>
            <td><span data-prefix>Rs. </span>
                <span>${booking.billGeneration.otherCharges}</span></td>
        </tr>
        <tr>
            <th><span>Total</span></th>
            <td><span data-prefix>Rs. </span><span id="total">0.00</span></td>
        </tr>
    </table>


</article>
<aside>
    <h4><span>Terms & Condition</span></h4>
    <div>
        <p>A finance charge of 1.5% will be made on unpaid balances after 30 days.</p>
    </div>
</aside>
</body>
</html>