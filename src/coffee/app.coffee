#dbServer = 'http://0.0.0.0:1234'
dbServer = 'http://192.168.0.175:1234'
#pg = require 'pg'
app = angular.module('PIS',['ui.router','ngTable'])
app.config(($stateProvider) ->
  $stateProvider
    .state('login', {
      url: "",
      views: {
        "viewA": { templateUrl: "loginHeader.html" },
        "viewB": { controller:'LoginCtrl',templateUrl: "login.html" }
      }
    })
    .state('dashboard', {
      url: "/dashboard",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
#        "viewB": { controller:'LoanCtrl',templateUrl: "hr/loan.html" }
        "viewB": { templateUrl: "dashboard.html" }
      }
    })
    .state('hrLoan', {
      url: "/hrLoan",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'LoanCtrl',templateUrl: "hr/loan.html" }
      }
    })
    .state('hrOvertime', {
      url: "/hrOvertime",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'OvertimeCtrl',templateUrl: "hr/overtime.html" }
      }
    })
    .state('hrOvertimeEmp', {
      url: "/hrOvertime/:ApplicationID",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'OvertimeEmpCtrl',templateUrl: "hr/overtimeEmp.html" }
      }
    })
    .state('hrAbsent', {
      url: "/hrAbsent",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AbsentCtrl',templateUrl: "hr/absent.html" }
      }
    })
    .state('hrAbsentEmp', {
      url: "/hrAbsent/:ApplicationID",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AbsentEmpCtrl',templateUrl: "hr/absentEmp.html" }
      }
    })
    .state('hrReimbursement', {
      url: "/hrReimbursement",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'ReimbursementCtrl',templateUrl: "hr/reimbursement.html" }
      }
    })
    .state('employeeProfile', {
      url: "/employeeProfile",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
#        "viewB": { controller:'ReimbursementCtrl',templateUrl: "hr/reimbursement.html" }
        "viewB": { templateUrl: "employee/profile.html" }
      }
    })
    .state('employeeAttendance', {
      url: "/employeeAttendance",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
#        "viewB": { controller:'ReimbursementCtrl',templateUrl: "hr/reimbursement.html" }
        "viewB": { templateUrl: "employee/attendance.html" }
      }
    })
    .state('leaveApply', {
      url: "/leaveApply",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
#        "viewB": { controller:'ReimbursementCtrl',templateUrl: "hr/reimbursement.html" }
        "viewB": { controller:'LeaveApplyCtrl',templateUrl: "employee/leaveApply.html" }
      }
    })
    .state('absentApply', {
      url: "/absentApply",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
#        "viewB": { controller:'ReimbursementCtrl',templateUrl: "hr/reimbursement.html" }
        "viewB": { controller:'LeaveApplyCtrl',templateUrl: "employee/absentApply.html" }
      }
    })

  .state('applySupportingDoc', {
      url: "/supportDocument",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
#        "viewB": { controller:'ReimbursementCtrl',templateUrl: "hr/reimbursement.html" }
        "viewB": { templateUrl: "employee/supportingDocs.html" }
      }
    })

    .state('loanApply', {
      url: "/loanApply",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'LoanApplyCtrl',templateUrl: "employee/loanApply.html" }
      }
    })
    .state('reimbursementApply', {
      url: "/reimbursementApply",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
#        "viewB": { controller:'ReimbursementCtrl',templateUrl: "hr/reimbursement.html" }
        "viewB": { templateUrl: "employee/reimbursementApply.html" }
      }
    })
    .state('overtimeApply', {
      url: "/overtimeApply",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
#        "viewB": { controller:'ReimbursementCtrl',templateUrl: "hr/reimbursement.html" }
        "viewB": { templateUrl: "employee/overtimeApply.html" }
      }
    })
    .state('hrReimbursementEmp', {
      url: "/hrReimbursement/:ApplicationID",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'ReimbursementEmpCtrl',templateUrl: "hr/reimbursementEmp.html" }
      }
    })
    .state('hrAssignShift', {
      url: "/hrAssignShift",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AssignShiftCtrl',templateUrl: "hr/assignShift.html" }
      }
    })
    .state('hrAssignShiftEmp', {
      url: "/hrAssignShift/:ApplicationID",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AssignShiftEmpCtrl',templateUrl: "hr/assignShiftEmp.html" }
      }
    })
    .state('hrLoanEmp', {
      url: "/hrLoan/:ApplicationID",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'LoanEmpCtrl',templateUrl: "hr/loanEmp.html" }
      }
    })
    .state('hrLeaveEmp', {
      url: "/hrLeave/:ApplicationID",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'LeaveEmpCtrl',templateUrl: "hr/leaveEmp.html" }
      }
    })
    .state('hrManualAttandance', {
      url: "/hrManualAttandance",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'ManualAttandanceCtrl',templateUrl: "hr/manualAttandance.html" }
      }
    })
    .state('addEmployee', {
      url: "/addEmployee",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'addEmpCtrl',templateUrl: "hr/addEmp.html" }
      }
    })
    .state('manageEmployeeList', {
      url: "/manageEmployeeList",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
#        "viewB": { templateUrl: "hr/manageEmpList.html" }
        "viewB": { controller:'manageEmployeeCtrl',templateUrl: "hr/manageEmpList.html" }
      }
    })
  .state('manageEmployee', {
      url: "/manageEmployee/:ApplicationID",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'manageEmployeeCtrl',templateUrl: "hr/manageEmp.html" }
      }
    })
    .state('hrLeave', {
      url: "/hrLeave",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'LeaveCtrl',templateUrl: "hr/leave.html" }
      }
    })
  .state('hrSubstituteEmployee', {
      url: "/hrSubstituteEmployee",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'substituteEmployeeCtrl',templateUrl: "hr/substituteEmployee.html" }
      }
    })
    .state('adminAddDept', {
      url: "/adminAddDepartments",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AddDepartmentsCtrl',templateUrl: "admin/addDepartment.html" }
      }
    })
  .state('adminAddLevel', {
      url: "/adminAddLevel",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'LevelsCtrl',templateUrl: "admin/addLevel.html" }
      }
    })
  .state('adminLevels', {
      url: "/adminLevels",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'LevelsCtrl',templateUrl: "admin/levels.html" }
      }
    })

  .state('adminEditLevel', {
      url: "/adminLevel/:levelId",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'LevelsCtrl',templateUrl: "admin/editLevel.html" }
      }
    })

  .state('adminDeptlist', {
    url: "/adminDepartments",
    views: {
      "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
      "viewB": { controller:'DepartmentsCtrl',templateUrl: "admin/departments.html" }
    }
  })

  .state('adminEditDepartments', {
      url: "/adminAddDepartments/:deptId",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'editDepartmentCtrl',templateUrl: "admin/addDepartment.html" }
      }
    })

  .state('adminAddHoliday', {
    url: "/adminAddHoliday",
    views: {
      "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
      "viewB": { controller:'AddHolidayCtrl',templateUrl: "admin/addHoliday.html" }
    }
  })

  .state('adminHolidaysList', {
      url: "/adminHolidays",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'HolidaysCtrl',templateUrl: "admin/holidays.html" }
      }
    })

  .state('adminAddDesignation', {
    url: "/adminAddDesignation",
    views: {
      "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
      "viewB": { controller:'AddDesignationsCtrl',templateUrl: "admin/addDesignation.html" }
    }
  })

  .state('designationsList', {
      url: "/adminDesignations",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'DesignationsCtrl',templateUrl: "admin/designations.html" }
      }
    })

  .state('adminEditDesignation', {
      url: "/adminAddDesignation/:desigId",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'addDepartmentCtrl',templateUrl: "admin/addDesignation.html" }
      }
    })
    .state('adminAddShift', {
      url: "/adminAddShift",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AddShiftCtrl',templateUrl: "admin/addShift.html" }
      }
    })
  .state('adminAddLoan', {
      url: "/adminAddLoan",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AddLoanCtrl',templateUrl: "admin/addLoan.html" }
      }
    })
  .state('adminLoansList', {
      url: "/adminLoans",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'LoansCtrl',templateUrl: "admin/loans.html" }
      }
    })
  .state('adminAddAbsent', {
      url: "/adminAddAbsent",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AbsentsCtrl',templateUrl: "admin/addAbsent.html" }
      }
    })

  .state('adminLeavesList', {
      url: "/adminAbsents",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AbsentsCtrl',templateUrl: "admin/absents.html" }
      }
    })
  .state('adminEditLeaves', {
      url: "/adminLeave/:leaveId",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AbsentsCtrl',templateUrl: "admin/editLeave.html" }
      }
    })
  .state('adminAddAbsentCategory', {
      url: "/adminAddAbsentCategory",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AbsentCategoriesCtrl',templateUrl: "admin/addAbsentCategory.html" }
      }
    })

  .state('adminAbsentCategories', {
      url: "/adminAbsentCategories",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'AbsentCategoriesCtrl',templateUrl: "admin/absentCategories.html" }
      }
    })
  .state('adminLeaveBenefits', {
      url: "/adminLeaveBenefits",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'',templateUrl: "admin/LeaveBenefits.html" }
      }
    })

  .state('adminCalendar', {
      url: "/adminCalendar",
      views: {
        "viewA": {  controller:'HeaderCtrl',templateUrl: "header.html" },
        "viewB": { controller:'',templateUrl: "admin/calendar.html" }
      }
    })
#    .otherwise(redirectTo : "/") /adminLeaves adminCalendar

  return
)