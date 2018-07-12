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

    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

    <asset:stylesheet src="booking/book.css"></asset:stylesheet>
    <asset:javascript src="booking/book.js"></asset:javascript>
    <asset:javascript src="Validate.js"></asset:javascript>

    <title></title>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
            <!-- Wizard container -->
            <div class="wizard-container">
                <div class="card wizard-card" data-color="red" id="wizard">
                    <g:form action="roomSelection">
                        <!--        You can switch " data-color="blue" "  with one of the next bright colors: "green", "orange", "red", "purple"             -->

                        <div class="wizard-header">
                            <h3 class="wizard-title">
                                Book a Room
                            </h3>
                            <h5>This information will let us know more about you.</h5>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <h4 class="info-text"> Let's start with the basic details.</h4>
                            </div>
                            <div class="col-sm-6">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">face</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">Guest Name</label>
                                        <td> <g:select name="titles" from="${['Mr', 'Mrs', 'Ms', 'C/O']}"/>
                                        <input name="customerName" title="customerName" id="customerName" type="text" class="form-control">
                                    </div>
                                </div>

                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">contact_phone</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">Phone No.</label>
                                        <input name="customerPhNo" title="customerPhNo" id="customerPhNo" type="text" class="form-control">
                                    </div>
                                </div>

                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">email</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">Email</label>
                                        <input name="customerEmail" type="text" title="customerEmail" id="customerEmail" class="form-control">
                                    </div>
                                </div>

                            </div>
                            <div class="col-sm-6">
                                <div class="form-group label-floating">
                                    <label class="control-label">Address</label>
                                    <input name="customerAddress" title="customerAddress" type="text" id="customerAddress" class="form-control">
                                </div>
                                <div class="form-group label-floating">
                                    <label class="control-label">No. Of Person</label>
                                    <input name="noOfPerson" title="noOfPerson" type="text" id="noOfPerson" class="form-control">
                                </div>
                                <div class='input-group date' id='checkInDate'>
                                    <input type='text' class="form-control" name="checkInDate"/>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                                <div class='input-group date' id='checkInTime'>
                                    <input type='text' class="form-control" name="checkInTime"/>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-time"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="wizard-footer">
                            <div class="pull-right">
                                <g:actionSubmit class="btn btn-next btn-fill btn-danger btn-wd" value="Next"  action="roomSelection"/>
                            </div>
                        </div>

                    </g:form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="application/javascript">
    $( function() {
        $('#checkInDate').datetimepicker({
            format: 'DD/MM/YYYY',
            defaultDate: new Date()
        });
        $('#checkInTime').datetimepicker({
            format: 'LT',
            defaultDate: new Date()
        });

        var myVal = {
            change_customerName_alert: "required( 'customerName', 'Mandatory to Enter!' ),alphabets('customerName','Invalid Name. Re-Enter!'),minLength('customerName',3,'Not Meeting Minimum Length criteria. Re-Enter!')"
            ,
            change_customerEmail_alert: "email('customerEmail','Not a valid Email Id. Re-Enter!'),minLength('customerEmail',6,'Not Meeting Minimum Length criteria. Re-Enter!')"
            ,
            change_customerPhNo_alert: "checkMobileNumber('customerPhNo','Invalid Mobile Number. Re-Enter!')"
            ,
            change_noOfPerson_alert: "numeric('noOfPerson','Invalid No Of Person!')"
            ,
            change_customerAddress_alert: "notEmpty('customerAddress','Invalid address entered. Re-Enter!'),alphaNumericSymbols('customerAddress','Invalid address entered. Re-Enter!')"
        };
        init_validations(myVal);
    });
</script>
</html>