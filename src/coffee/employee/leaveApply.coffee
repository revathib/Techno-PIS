app.service 'LeaveApply',($http)->
  @retrieveApplications=()->
    $http
    .get(dbServer+'/retrieveLeave',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
        return data
      )
    .error((data,status,headers,config)->
      )
  @retrieveLeaveTypes=()->
    $http
    .get(dbServer+'/retrieveLeaveTypes',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @newLeaveApplication=(application)->
    $http
    .post(dbServer+'/newLeaveApplication',params: {application:application,user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config) ->
    )
  return

app.controller 'LeaveApplyCtrl', ($scope,$stateParams,LeaveApply,$filter, ngTableParams) ->
  leaveList = ()->
    LeaveApply.retrieveApplications().then (data)->
      data = data.data
      $scope.dataTableLeaveApply = new ngTableParams(
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
  leaveList();
  LeaveApply.retrieveLeaveTypes().then (data)->
    $scope.leaveType=data.data
  $scope.submit = () ->
    LeaveApply.newLeaveApplication($scope.application).then (data) ->
      if data.data.result
        $scope.leave=true;
        leaveList()
        $scope.application={
          fromDate: "",
          toDate: "",
          leaveType: "",
          reason: ""
        }
  return

