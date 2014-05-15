app.service('AttendanceService',($http)->
  @retrieveEmployeesAttendance=(user,date)->
    $http
    .get(dbServer+'/retrieveEmployeesAttendance',user)
    .success((data,status,headers,config)->
      data.result
    )
    .error((data,status,headers,config)->
    )
  return
  return
)
app.controller 'ManualAttendanceCtrl', ($scope,AttendanceService)->
  AttendanceService.retrieveEmployeesAttendance($scope.user).then (data)->
  $scope.submit=()->

