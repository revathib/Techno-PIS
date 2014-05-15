app.service 'LoanManagement',($http)->
  @retrieveApplications=()->
    $http
    .get(dbServer+'/retrieveLoanList',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @retrieveApplicationById=(ApplicationId)->
    $http
    .get(dbServer+'/retrieveLoanId',params: {ApplicationId:ApplicationId})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @retrieveApplicationsForUser=(ApplicationId)->
    $http
    .get(dbServer+'/retrieveLoanApplicationsForUser',params: {ApplicationId:ApplicationId})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @LoanApplicationAction=(application,action)->
    $http
    .post(dbServer+'/loanApplicationAction',params: {application:application,action:action})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  return

app.controller 'LoanCtrl', ($scope,LoanManagement,$filter, ngTableParams)->
  LoanManagement.retrieveApplications().then (data)->
    data = data.data
    $scope.dataTableHrManageLoan = new ngTableParams(
      page: 1 # show first page
      count: 10 # count per page
      sorting: {
        applicationDate: 'asc'
      }
    ,
      total: data.length # length of data
      getData: ($defer, params) ->

        # use build-in angular filter
        filteredData = (if params.filter() then $filter("filter")(data, params.filter()) else data)
        orderedData = (if params.sorting() then $filter("orderBy")(filteredData, params.orderBy()) else data)
        params.total orderedData.length # set total for recalc pagination
        $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
        return
    )
    return
  return


app.controller 'LoanEmpCtrl', ($scope,$stateParams,LoanManagement,$filter,ngTableParams,$window)->
  $scope.application = {}
  LoanManagement.retrieveApplicationById($stateParams.ApplicationID).then (data)->
    console.log data.data
    $scope.application = {
      amount: data.data.amount,
      loanType: data.data.loanType,
      empID: data.data.empId,
      applicationDate: data.data.applicationDate,
      applicationID: data.data.applicationID,
      rateOfInterest: data.data.rateOfInterest,
      duration: data.data.duration
    }
    console.log $scope.application
  LoanManagement.retrieveApplicationsForUser($stateParams.ApplicationID).then (data)->
    data = data.data
    $scope.dataTableHrLoanEmp = new ngTableParams(
      page: 1 # show first page
      count: 10 # count per page
    ,
      total: data.length # length of data
      getData: ($defer, params) ->

        # use build-in angular filter
        filteredData = (if params.filter() then $filter("filter")(data, params.filter()) else data)
        orderedData = (if params.sorting() then $filter("orderBy")(filteredData, params.orderBy()) else data)
        params.total orderedData.length # set total for recalc pagination
        $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
        return
    )
    return
  $scope.Action = (action) ->
    LoanManagement.LoanApplicationAction($scope.application,action).then (data)->
      if data.data.result
        $window.location='#/hrLoan'
  return
