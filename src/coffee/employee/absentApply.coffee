app.service 'AbsentApply',($http)->
  @retrieveApplications=()->
    $http
    .get(dbServer+'/retrieveAbsent',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
        return data
      )
    .error((data,status,headers,config)->
      )
  @retrieveAbsentTypes=()->
    $http
    .get(dbServer+'/retrieveAbsentTypes',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @newAbsentApplication=(application)->
    $http
    .post(dbServer+'/newAbsentApplication',params: {application:application,user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  return

app.controller 'AbsentApplyCtrl', ($scope,$stateParams,AbsentApply,$filter, ngTableParams)->
  absentList = ()->
    AbsentApply.retrieveApplications().then (data)->
      data = data.data
      $scope.dataTableAbsentApply = new ngTableParams(
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
  absentList();
  AbsentApply.retrieveAbsentTypes().then (data)->
    $scope.absentType=data.data
  $scope.submit =()->
    AbsentApply.newAbsentApplication($scope.application).then (data)->
      if data.data.result
        $scope.absent=true;
        absentList()
        $scope.application={
          fromDate: "",
          toDate: "",
          absentType: "",
          reason: ""
        }
  return

