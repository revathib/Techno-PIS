app.service 'loansService', ($http) ->

  @createNewLoan = (loanType,rateOfInterest,fromDate,todate,description) ->
    console.log 'new loan added'
    $http
    .post(dbServer + '/addLoans', params : {loanType:loanType,rateOfInterest:rateOfInterest,fromDate:fromDate,todate:todate,description:description})
    .success((data, status, headers, config) ->
#      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveLoans = () ->
    console.log "loans"
    $http
    .get(dbServer+'/retrieveLoans')
    .success((data,status,headers,config) ->
      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveLoansById = (loanId) ->
    $http
    .get(dbServer + '/retrieveLoansById', params: {loanId:loanId})
    .success((data,status,headers,config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )

  @editLoans = (application, loanId) ->
    $http
    .post(dbServer + 'editLoans', {application:application, loanId:loanId})
    .success((data, status, headers, config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )

  return

app.controller 'AddLoanCtrl', ($scope, $location, loansService) ->
  $scope.createNew = ->
    loansService.createNewLoan($scope.loan.type, $scope.loan.rateOfInterest, $scope.loan.description).then (data) ->
      if data.data.result
        $window.location='#/adminAddLoans'
    return
    $location.path('/adminLoans')

app.controller 'LoansCtrl', ($scope, loansService) ->
  $scope.loans = []
  loansService.retrieveLoans().then (data) ->
    $scope.loans = data.data
  return


#app.controller 'AddLoanCtrl', ($scope, Loans, $location) ->
#  $scope.createLoan = ->
#    Loans.add $scope
#    $location.path('/admin/showLoans')
#
#app.factory 'Loans', ->
#  loans = [
#    {
#      id:"1"
#      loanName:"abc"
#      description:"fdhgdth"
#    }
#    {
#      id:"2"
#      loanName:"xyz"
#      description:"fdhgdth"
#    }
#  ]
#
#  pick_loan = (l) -> _.pick l, ['leaveName', 'description']
#  get: (id) -> loan[id]
#  index: -> loans
#  update: (l) -> _.assign (get l.id), (pick_loan l)
#  add: (l) -> loans.push (_.assign { id: loans.length }, (pick_loan l))
