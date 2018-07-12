package Testuser

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.web.servlet.ModelAndView
import testuser.BillGeneration
import testuser.HotelDetails
import testuser.HotelRegistration

import static org.springframework.http.HttpStatus.*
@Secured('ROLE_USER')
class BookingController {
    Testuser.BookingService bookingService
    SpringSecurityService springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond bookingService.list(params), model:[bookingCount: bookingService.count()]
    }

    def show(Long id) {
        respond bookingService.get(id)
    }

    def create() {
        respond new Booking(params)
    }

    def save(Booking booking) {
        if (booking == null) {
            notFound()
            return
        }

        try {
            bookingService.save(booking)
        } catch (ValidationException e) {
            respond booking.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'booking.label', default: 'Booking'), booking.id])
                redirect booking
            }
            '*' { respond booking, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond bookingService.get(id)
    }

    def update(Booking booking) {
        if (booking == null) {
            notFound()
            return
        }

        try {
            bookingService.save(booking)
        } catch (ValidationException e) {
            respond booking.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'booking.label', default: 'Booking'), booking.id])
                redirect booking
            }
            '*'{ respond booking, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        bookingService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'booking.label', default: 'Booking'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'booking.label', default: 'Booking'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def checkIn(){
        render(view:'checkIn')
    }

    def roomSelection() {
        User user = (User) springSecurityService.currentUser
        HotelRegistration hr = HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        List<HotelRooms> hotelRoomsList = hotelDetails.hotelRooms.findAll()
        int r = (hotelRoomsList?.size()) / 10
        render(view: 'roomSelection', model: [hotelRoomsList: hotelRoomsList, r: r, p: params])
    }

    def roomSelectionEdit()
    {
        User user = (User) springSecurityService.currentUser
        HotelRegistration hr = HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        String id = params.bookingId
        Long bookingId = id.toLong()
        Booking booking = Booking.findById(bookingId)
        if (!booking.roomsBooked) {
            List<HotelRooms> hotelRoomsList = hotelDetails.hotelRooms.findAll()
            int r = (hotelRoomsList?.size()) / 10
            render(view: 'roomSelection', model: [hotelRoomsList: hotelRoomsList, r: r, p: params])
        }
        else {
                List<HotelRooms> hotelRoomsBooked = booking.roomsBooked
                List<HotelRooms> hotelRoomsList = hotelDetails.hotelRooms.findAll()
                int r = (hotelRoomsList?.size()) / 10
                render(view: 'roomSelectionEdit', model: [hotelRoomsBooked: hotelRoomsBooked, hotelRoomsList: hotelRoomsList,r: r, p: params])

        }
    }
    def submitForm()
    {
        User user = (User)springSecurityService.currentUser
        HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        Booking booking1 = new Booking(customerName: params.customerName,customerAddress: params.customerAddress,customerEmail:params.customerEmail,customerPhNo: params.customerPhNo,bookedBy: params.bookedBy,blockedBy: params.blockedBy )
        String noOfPerson = params.noOfPerson
        booking1.noOfPerson = noOfPerson?.toInteger()
        String inDate = params.checkInDate
        Date checkInDate = new Date().parse("dd/MMM/yyyy",inDate)
        booking1.checkInDate = checkInDate
        String inTime = params.checkInTime
        Date checkInTime = new Date().parse("hh:mm aa",inTime)
        booking1.checkInTime = checkInTime
        booking1.hotelDetails = hotelDetails
        if (!booking1.billGeneration)
        {
            BillGeneration billGeneration = new BillGeneration()
            billGeneration.billNo = billGeneration.id
            if(params.oyo != null)
            {
                String oyo = params.oyo
                double oyoAdvance = oyo.toDouble()
                billGeneration.oyoAdvance = oyoAdvance
            }
            if(params.cash != null)
            {
                String cash = params.cash
                double cashAdvance = cash.toDouble()
                billGeneration.cashAdvance = cashAdvance
            }
            if(params.cash != null)
            {
                String paytm = params.paytm
                double paytmAdvance = paytm.toDouble()
                billGeneration.paytmAdvance = paytmAdvance
            }
            billGeneration.save(flush: true,failOnError : true)
            booking1.billGeneration = billGeneration
        }
        List values = request.getParameterValues("check")
        List<HotelRooms> hotelRoomsList = HotelRooms.findAllByRoomNoInList(values)
        hotelRoomsList.each {
            booking1.roomsBooked.add(it.roomNo)
            it.availability = "No"
            it.save(flush: true,failOnError : true)
        }
        hotelDetails.bookings.add(booking1)
        hotelDetails.save(flush: true,failOnError : true)

        flash.message = "successfully booked"
        chain(controller:'default',action: 'dash')
    }
    def editForm()
    {
        User user = (User)springSecurityService.currentUser
        HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        String id = params.bookingId
        Long bookingId = id.toLong()
        Booking booking1 = Booking.findById(bookingId)
        booking1.customerName = params.customerName
        booking1.customerAddress = params.customerAddress
        booking1.customerEmail = params.customerEmail
        booking1.customerPhNo = params.customerPhNo
        booking1.bookedBy = params.bookedBy
        booking1.blockedBy = params.blockedBy
        String noOfPerson = params.noOfPerson
        booking1.noOfPerson = noOfPerson?.toInteger()
        String inDate = params.checkInDate
        Date checkInDate = new Date().parse("dd/MMM/yyyy",inDate)
        booking1.checkInDate = checkInDate
        String inTime = params.checkInTime
        Date checkInTime = new Date().parse("hh:mm aa",inTime)
        booking1.checkInTime = checkInTime
        booking1.hotelDetails = hotelDetails

        if(booking1.bookingStatus=="Open")
        {
            List<String> oldRoomsList = booking1.roomsBooked
            oldRoomsList.each { it ->
                HotelRooms hotelRooms = HotelRooms.findByRoomNo(it)
                hotelRooms.availability = "Yes"
                hotelRooms.save(flush: true, failOnError: true)
            }
            booking1.roomsBooked = []
            List values = request.getParameterValues("check")
            List<HotelRooms> hotelRoomsList = HotelRooms.findAllByRoomNoInList(values)
            hotelRoomsList.each {
                booking1.roomsBooked.add(it.roomNo)
                it.availability = "No"
                it.save(flush: true, failOnError: true)
            }
        }
        else
        {
            List<String> oldRoomsList = booking1.roomsBooked
            oldRoomsList.each { it ->
                HotelRooms hotelRooms = HotelRooms.findByRoomNo(it)
                hotelRooms.availability = "Yes"
                hotelRooms.save(flush: true, failOnError: true)
            }
            booking1.roomsBooked = []
            List values = request.getParameterValues("check")
            List<HotelRooms> hotelRoomsList = HotelRooms.findAllByRoomNoInList(values)
            hotelRoomsList.each {
                booking1.roomsBooked.add(it.roomNo)
                it.availability = "No"
                it.save(flush: true, failOnError: true)
            }
        }

        hotelDetails.bookings.add(booking1)
        hotelDetails.save(flush: true,failOnError : true)
        flash.message = "successfully booked"
        chain(controller:'default',action: 'dash')
    }

    def viewBooking()
    {
        User user = (User)springSecurityService.currentUser
        HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        String id = params.id
        Long bookingId = id.toLong()
        Booking booking = Booking.findById(bookingId)
        String checkInDate = booking.checkInDate.format("dd/MMM/yyyy")
        String checkInTime = booking.checkInTime.format("HH:mm")
        render(view: '/booking/viewBooking',model: [booking:booking,hr: hr,hotelDetails:hotelDetails,checkInTime:checkInTime,checkInDate:checkInDate])
    }
    def guestList(){
        User user = (User)springSecurityService.currentUser
        HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        List<Booking> booking1 = hotelDetails.bookings.findAll()
        render(view: 'guestList', model: [booking1:booking1])
    }
    def detailList(){
        User user = (User)springSecurityService.currentUser
        HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        List<Booking> booking1 = hotelDetails.bookings.findAll()
        render(view: 'detailList', model: [booking1:booking1])
    }
    def filterBookings(){
        String name = params.name
        String n = "%" + name + "%"
        String phNo = params.customerPhNo
        String ph = "%" +phNo + "%"
        String status = params.status
        String invoiceDate = params.invoiceDate
        User user = (User)springSecurityService.currentUser
        HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        List<Booking> booking1 = []
        if (invoiceDate){
            Date invDate = new Date().parse("dd/MMM/yyyy",invoiceDate)
            if (status){
                booking1 =  Booking.findAllByBillGenerationInListAndHotelDetailsAndCustomerNameIlikeAndCustomerPhNoIlikeAndBookingStatus(BillGeneration.findAllByInvoiceDate(invDate),hotelDetails,n,ph,status)
            }else {
                booking1 =  Booking.findAllByBillGenerationInListAndHotelDetailsAndCustomerNameIlikeAndCustomerPhNoIlike(BillGeneration.findAllByInvoiceDate(invDate),hotelDetails,n,ph)
            }
        }else{
            if (status){
                booking1 = Booking.findAllByHotelDetailsAndCustomerNameIlikeAndCustomerPhNoIlikeAndBookingStatus(hotelDetails,n,ph,status)
            }else {
                booking1 = Booking.findAllByHotelDetailsAndCustomerNameIlikeAndCustomerPhNoIlike(hotelDetails,n,ph)
            }
        }
        String htmlContent = g.render([template:"bookingList", model:[booking1:booking1]])
        Map responseData = [htmlContent:htmlContent]
        render(responseData as JSON)
    }
    def filterBooking(){

        String maxDateRange = params.maxDateRange
        Date endDate = new Date().parse("dd/MMM/yyyy",maxDateRange)
        String minDateRange = params.minDateRange
        Date startDate = new Date().parse("dd/MMM/yyyy",minDateRange)
        User user = (User)springSecurityService.currentUser
        HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        List<Booking> booking1 = []
        List<Booking> bookings = []
        bookings = Booking.findAllByHotelDetails(hotelDetails)
        bookings.each { b ->
            if(b.checkInDate>=startDate && b.checkInDate<=endDate)
            {
                booking1.add(b)
            }
        }
        String htmlContent = g.render([template:"reportList", model:[booking1:booking1]])
        Map responseData = [htmlContent:htmlContent]
        render(responseData as JSON)
    }

    def viewBill()
    {
        User user = (User)springSecurityService.currentUser
        HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        String id = params.id
        Long bookingId = id.toLong()
        Booking booking = Booking.findById(bookingId)
        String checkInTime = booking.checkInTime.format("HH:mm")
        String checkInDate = booking.checkInDate.format("dd/MMM/yyyy")
        render(view: '/billGeneration/createinvoice',model: [booking:booking,hr: hr,hotelDetails:hotelDetails,checkInTime:checkInTime,checkInDate:checkInDate])
    }
    def checkOut()
    {
        User user = (User)springSecurityService.currentUser
        HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        String id = params.id
        Long bookingId = id.toLong()
        Booking booking = Booking.findById(bookingId)
        Date date = new Date()
        String datePart = date.format("dd/MMM/yyyy")
        String timePart = date.format("HH:mm")
        Date checkOutDate = new Date().parse("dd/MMM/yyyy",datePart)
        Date checkOutTime = new Date().parse("HH:mm",timePart)
        booking.save(flush: true,failOnError : true)
        String checkInDate = booking.checkInDate.format("dd/MMM/yyyy")
        String checkInTime = booking.checkInTime.format("HH:mm")
        String days = checkOutDate - booking.checkInDate
        int noOfDays = days.toInteger()
        double advPaymentAmt= booking.billGeneration.cashAdvance + booking.billGeneration.oyoAdvance + booking.billGeneration.paytmAdvance
        return new ModelAndView("/billGeneration/bill", [booking:booking,checkInDate:checkInDate,checkInTime:checkInTime,noOfDays:noOfDays,advPaymentAmt:advPaymentAmt, hr:hr, hotelDetails:hotelDetails])
    }
}
