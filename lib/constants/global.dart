class Global {
  //local

  //static const hostUrl = "http://192.168.10.77:8053"; //tpLink
  //static const hostUrl = "http://192.168.10.77:7072"; //new
  //static const hostUrl = "http://192.168.10.196:7072"; //new

  //testing
  //static const hostUrl = "http://192.168.10.122:7072";
  //dev
   static const hostUrl = "http://103.16.222.44:85";

  //login api
  static const login = '/OTPLogin';
  //otp login
  static const otp = '/mobileLogin';
  //getCalender api
  static const getCalender = '/callenderAndroid';
  //getReport api
  static const getReport = '/Mobileattendancereport';
  //getReport api
  static const notification = '//mobileAppNotification/';
  //forgotOtp api
  static const forgotOtp = '/forgotPassworldOtpGenerate';
  //verifyOtp api
  static const verifyOtp = '/verifyOtp';
  //updatePassword api
  static const updatePassword = '/updatePassworld';
  //updatePassword api
  static const updateOrsaveFcm = '/updateOrsaveFcm';
  //mobileLogout api
  static const mobileLogout = '/Logout';
  //lateEarlyList api
  static const lateEarlyList = '/LateEarlyList/';
  //lateEarlyList api
  static const earlyLateList = '/EarlyLateList/';
  //shiftList api
  static const shiftList = '/ShiftMaster/';
  //permission request
  static const permissionReq = '/RequestPR';
  //pRrequestEdit request
  static const pRrequestEdit = '/PRrequestEdit';
  //RequestLateEarly request
  static const requestLateEarly = '/RequestLateEarly';
  //lateEarlyEditrequest request
  static const lateEarlyEditrequest = '/LateEarlyEditrequest';
  //RequestOD request
  static const requestOD = '/RequestOD';
  //oDrequestEdit request
  static const oDrequestEdit = '/ODrequestEdit';
  //RequestWFH request
  static const requestWFH = '/RequestWFH';
  //wFHrequestEdit request
  static const wFHrequestEdit = '/WFHrequestEdit';
  //RequestMissPunch Api
  static const requestMissPunch = '/RequestMissPunch';
  //missPunchrequestEdit Api
  static const missPunchrequestEdit = '/MissPunchrequestEdit';
  //extraworking Api
  static const extraworking = '/extraworking';
  //extraworkrequest Api
  static const extraworkrequest = '/extraworkrequest';
  //empLeavesBalanceDetails Api
  static const empLeavesBalanceDetails = '/EmpLeavesBalanceDetails/';
  //leaveApi Api
  static const leaveApi = '/leaverequest';
  //requestLateEarlyApi Api
  static const requestLateEarlyApi = '/requestLateEarlyList';
  //getPermissionArList Api
  static const getPermissionArList = '/requestpr';
  //getMissPunchArList Api
  static const getMissPunchArList = '/requestmisspunch';
  //getODArListAPI Api
  static const getODArListAPI = '/requestod';
  //getWFHArListAPI Api
  static const getWFHArListAPI = '/requestwfh';
  //getWFHArListAPI Api
  static const getEwrArListAPI = '/requestextraworkinglist';
  //getLeaveList Api
  static const getLeaveList = '/requestApplication';
  //leaveRequestDelete Api
  static const leaveRequestDelete = '/LeaveRequest/';
  //leaveRequestUpdate Api
  static const leaveRequestUpdate = '/updateleave';
  //getPendingCountApi Api
  static const getPendingCountApi = '/getPendingRegularisation?empId=';
  //getEmployeeLateEarlyCountApi Api
  static const getEmployeeLateEarlyCountApi = '/employeeLateEarly/';
  //getEmployeeLateEarlyCountApi Api
  static const getEmployeeMissPunchCountApi = '/employeemisspunch/';
  //getMobileAppPunchList Api
  static const getMobileAppPunchList = '/getMobileAppPunchList/';
  //getEmployeeMissPunchCountAPi
  static const getEmployeeWFHCountApi = '/employeewfh/';
  //getEmployeeWFHCountAPi
  static const onSitePunch = '/MobileAppPunch';
  //approveLEAPI Api
  static const approveLEAPI = '/ApproveOtherLateearlyAttendanceData';
  //rejectLEAPI Api
  static const rejectLEAPI = '/rejectOtherLateearlyAttendanceData';
  //approveMissPUnch api
  static const approveMissPunchApi = '/ApproveOtherMissPunchAttendanceData';
  //approveCoffApi api
  static const approveCoffApi = '/ApproveOtherCoffAttendanceData';
  //rejectCoffApi api
  static const rejectCoffApi = '/rejectOtherCoffAttendanceData';
  //rejectMissPUnch api
  static const rejectMissPunchApi = '/rejectOtherMissPunchAttendanceData';
  //approveWFH Api
  static const approveWFHApi = '/ApproveOtherWFHAttendanceData';
  //rejectWFH api
  static const rejectWFHApi = '/rejectOtherWFHAttendanceData';
  //getEmployeeOnDutyCOunt api
  static const getEmployeeOnDutyCountApi = '/employeeod/';
  //approveOnDuty api
  static const approveOnDutyAPI = '/ApproveOtherODAttendanceData';
  //rejectOnDytyAPi
  static const rejectOnDutyApi = '/rejectOtherODAttendanceData';
  //approveLARAPI Api
  static const approveLARAPI = '/ApproveLeaveRequestAttendanceData';
  //rejectLARRAPI Api
  static const rejectLARRAPI = '/rejectOtherLeaveRequestAttendanceData';
  //getEmployeeLeaveRequestApproveCountApi Api
  static const getEmployeeLeaveRequestApproveCountApi = '/leaverequest/';
  //getEmployeeEWRCountApi Api
  static const getEmployeeEWRCountApi = '/extraworking/';
  //rejectEWRApi Api
  static const rejectEWRApi = '/rejectExtraWorkingRequest';
  //approveExtraWorkingRequestApi Api
  static const approveExtraWorkingRequestApi = '/ApproveExtraWorkingRequest';
  //getEmployeeRequestCoff API
  static const getEmployeeRequestCoffApi = '/coffrequestunderemp/';
  //getEmployeeAllRequestCancle API
  static const getEmployeeAllRequestCancleApi = '/AllCancelRequest/';
  //getEmployeePRRequestrCount APi
  static const getEmployeePRRequestCountApi = '/employeepr/';
  //approvePRRequest api
  static const approvePRRequestApi = '/ApprovedOtherPRAttendanceData';
  //rejectPRRequstAPi
  static const rejectPRRequestApi = '/rejectOtherPRAttendanceData';
  //getCoffRegularisationApi
  static const getCoffRegularisationApi = '/coffregularisation/';
  //getemployee punch data
  static const getEmployeePunchData = '/getMobileAppPunch/';
  //getMobilePunchRequest api
  static const getMobilePunchApprovalList = '/getMobileAppPunchList/';
  //getFuelExpense chargs
  static const getFuelExpenseCharges = '/getFuelExpenseCharges';
  //approve mobile app punch request
  static const approveMobileAppPunchReq = '/MobilePunchRequestApproved';
  //Reject mobile app punch request
  static const rejectMobileAppPunchReq = '/MobilePunchRequestApproved';
  //mobilepunch pending details
  static const getMobilePunchPendingDataList = '/getEmployeePunchPendingList/';
  //mobilepunch Approved details
  static const getMobilePunchApprovedDataList = '/getEmployeePunchApproveList/';
  //mobilepunch rejected details
  static const getMobilePunchRejectedDataList =
      '/getEmployeePunchRejectedList/';
  //getMobileAppPunchList details
  static const getMobileAppPunchListFuel = '/getPunchListFuelExpense/';

//get Remimbursment count api
  static const getRemimbursmentCountApi = '/getReimbursmentApprovalsData';
  //getEmployee punch list
  static const getEmployeePunchList = '/getEmployeeList';
  //post fuel expense
  static const createFuelExpense = '/createFuelExpenseRequest';
  //getFuelApprovals expense
  static const getFuelApprovals = '/getMobileAppFuelExpenseList/';
  static const approveFuelExpense = '/MobileFuelExpenseRequestApproved';
  static const getEmployeeFuelExpenseList = '/getEmployeeFuelExpenseList';
  //update home locaiton
  static const updateHomeLocation = "/UpdateHomeLocation/";

  //........................................................//
  //PR Approved cancel request
  static const cancelPrApproe = '/RequestPR';
  //Miss punch Approve cancel requst
  static const cancelMissPunchApprove = '/RequestMissPunch';
  // late early approve cancel
  static const cancelLateEarlyApprove = '/RequestLateEarly';
  //od aapporve cnacel
  static const cancelODApprove = '/RequestOD';
  //approveCancelOrRejectRequestcnacel
  static const approveCancelOrRejectRequest = '/ApproveCancelOrRejectRequest';
  //createReimbursmentRequest
  static const createReimbursmentRequest = '/createReimbursmentRequest';
  //updateReimbursmentRequest
  static const updateReimbursmentRequest = '/updateReimbursmentRequest';
  //getReimbursmentRequest
  static const getReimbursmentRequest = '/GetReimbursmentRequest';
  //delete reimbursment
  static const deleteReimbursmentRequest = '/deleteReimbursmentRequest';
  // ReimbursmentRequestApproved
  static const reimbursmentRequestApproved = '/ReimbursmentRequestApproved';
  // ReimbursmentRequestRejected
  static const reimbursmentRequestRejected = '/ReimbursmentRequestRejected';
}
