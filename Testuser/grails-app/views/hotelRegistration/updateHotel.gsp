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
    <g:hasErrors bean="${this.hotelRegistration}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.hotelRegistration}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
            <!-- Wizard container -->
            <div class="wizard-container">
                <div class="card wizard-card" data-color="red" id="wizard">
                    <g:form action="updateHotelRegister">
                        <!--        You can switch " data-color="blue" "  with one of the next bright colors: "green", "orange", "red", "purple"             -->

                        <div class="wizard-header">
                            <h3 class="wizard-title">
                                Update Hotel Details
                            </h3>
                            <h5>This is new Hotel Registration form after checking all details.</h5>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <h4 class="info-text"> </h4>
                            </div>
                            <div class="col-sm-6">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">create</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">Hotel Name</label>
                                        <input name="hotelName" title="hotelName" id="hotelName" type="text" class="form-control" value="${hotelRegistration.hotelName}">
                                    </div>
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">email</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">Username</label>
                                        <input name="email" type="text" title="email" id="email" class="form-control" value="${hotelRegistration.email}">
                                    </div>
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">event_note</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">Password</label>
                                        <input name="password" title="password" type="text" id="password" class="form-control" value="${hotelRegistration.password}">
                                    </div>
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">contact_mail</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">Address</label>
                                        <input name="address" title="address" type="text" id="address" class="form-control" value="${hotelRegistration.address}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">info</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">GSTIN</label>
                                        <input name="gstin" title="gstin" id="gstin" type="text" class="form-control" value="${hotelRegistration.gstin}">
                                    </div>
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">hotel</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">Hotel License No.</label>
                                        <input name="hotelLicenceNo" title="hotelLicenceNo" id="hotelLicenceNo" type="text" class="form-control" value="${hotelRegistration.hotelLicenceNo}">
                                    </div>
                                </div>

                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="material-icons">local_dining</i>
                                    </span>
                                    <div class="form-group label-floating">
                                        <label class="control-label">Food License No.</label>
                                        <input name="foodLicenceNo" title="foodLicenceNo" id="foodLicenceNo" type="text" class="form-control" value="${hotelRegistration.foodLicenceNo}">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="wizard-footer">
                            <div class="pull-right">
                                <g:actionSubmit class="btn btn-success btn-wd" value="Update" action="updateHotelRegister"/>
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
        var myVal = {
            change_hotelName_alert: "required('hotelName','Mandatory to Enter!'),alphanumeric('hotelName','Invalid Hotel Name!')"
            ,
            change_gstin_alert: "required('gstin','Mandatory to Enter!'),alphanumeric('gstin','Invalid GSTIN Number!')"
            ,
            change_email_alert: "required('email','Mandatory to Enter!'),email('email','Invalid Number!')"
            ,
            change_password_alert: "required('password','Mandatory to Enter!'),checkPassword('password','Invalid Password!')"
            ,
            change_address_alert: "alphaNumericSymbols('address','Invalid Address. Re-Enter!')"
        };
        init_validations(myVal);
    });
</script>
</html>