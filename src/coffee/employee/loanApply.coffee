app.service 'LoanApply',($http)->
  @retrieveApplications=()->
    $http
    .get(dbServer+'/retrieveLoan',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
        return data
      )
    .error((data,status,headers,config)->
      )
  @retrieveLoanTypes=()->
    $http
    .get(dbServer+'/retrieveLoanTypes',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @newLoanApplication=(application)->
    $http
    .post(dbServer+'/newLoanApplication',params: {application:application,user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  return

app.controller 'LoanApplyCtrl', ($scope,$stateParams,LoanApply,$filter, ngTableParams)->
  $scope.application={
    loanAmount:0,
    duration:1,
    rateOfInterest:0,
    EMI:0
  }
  loanList = ()->
    LoanApply.retrieveApplications().then (data)->
      data = data.data
      $scope.dataTableLoanApply = new ngTableParams(
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
  loanList();
  LoanApply.retrieveLoanTypes().then (data)->
    $scope.loanType=data.data
  $scope.submit =()->
    LoanApply.newLoanApplication($scope.application).then (data)->
      if data.data.result
        $scope.loan=true;
        loanList()
        $scope.application={
          loanType: "",
          loanAmount: 0,
          duration: 1,
          rateOfInterest: 0,
          EMI:0
        }
  $scope.changeLoanType = () ->
    if $scope.application.loanType==null || $scope.application.loanType==undefined
      $scope.application.rateOfInterest = 0
    _.each $scope.loanType, (loanType)->
      if loanType.loanType==$scope.application.loanType
        $scope.application.rateOfInterest = loanType.rateOfInterest
        $scope.calculateEMI();
  $scope.calculateEMI = () ->
    P=parseInt($scope.application.loanAmount)
    R=parseInt($scope.application.rateOfInterest)/12/100
    N=parseInt($scope.application.duration)
    EMI=P*R*Math.pow((1+R),N)/(Math.pow((1+R),N)-1)
    $scope.application.EMI = Math.round(EMI*100)/100

  return

