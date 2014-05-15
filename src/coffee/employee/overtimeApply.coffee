app.service 'OvertimeApply',($http)->
  @retrieveApplications=()->
    $http
    .get(dbServer+'/retrieveOvertime',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
        return data
      )
    .error((data,status,headers,config)->
      )
  @newOvetimeApplication=(application)->
    $http
    .post(dbServer+'/newOvertimeApplication',params: {application:application,user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  return

app.controller 'OvertimeApplyCtrl', ($scope,$stateParams,OvertimeApply,$filter, ngTableParams)->
  overtimeList = ()->
    OvertimeApply.retrieveApplications().then (data)->
      data = data.data
      $scope.dataTableOvertimeApply = new ngTableParams(
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
  overtimeList();
  $scope.submit =()->
    OvertimeApply.newOvertimeApplication($scope.application).then (data)->
      if data.data.result
        $scope.leave=true;
        overtimeList()
        $scope.application={
          date:"",
          from: "",
          to: "",
          reason: ""
        }
  return

