app.service 'holidaysService', ($http) ->

  @createNewHoliday = (holidayName,holidayDate) ->
    console.log 'new holiday added'
    $http
    .post(dbServer + '/addHoliday', params : {holidayName:holidayName,holidayDate:holidayDate})
    .success((data, status, headers, config) ->
#      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveHolidays = () ->
    console.log "holidays"
    $http
    .get(dbServer+'/retrieveHolidays')
    .success((data,status,headers,config) ->
      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveLeavesById = (deptId) ->
    $http
    .get(dbServer + '/retrieveLeavesById', params: {leaveId:leaveId})
    .success((data,status,headers,config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )

  @editLeaves = (application, leaveId) ->
    $http
    .post(dbServer + 'editLeaves', {application:application, leaveId:leaveId})
    .success((data, status, headers, config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )

  return

app.controller 'AddHolidayCtrl', ($scope, $location, holidaysService) ->
  $scope.createNew = ->
    holidaysService.createNewHoliday($scope.holiday.name, $scope.holiday.date).then (data) ->
      if data.data.result
        $window.location='#/adminDepartmentLeaves'
    return
    $location.path('/adminLeaves')

app.controller 'HolidaysCtrl', ($scope, holidaysService) ->
  $scope.holidays = []
  holidaysService.retrieveHolidays().then (data) ->
    $scope.holidays = data.data
  return

app.controller 'HolidaysCtrl', ($scope,holidaysService,$filter,ngTableParams) ->
  holidaysService.retrieveHolidays().then (data)->
    data = data.data
    $scope.holidaysTable = new ngTableParams(
      page: 1 # show first page
      count: 5 # count per page
      sorting: {
        holidayId: 'asc'
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
#app.controller 'editDepartmentCtrl', ($scope, $param, departmentsService) ->
#  departmentsService.retrieveDepartmentById($param.deptId).then (data) ->
#    $scope.departments = {
#      deptName: data.data.deptName,
#      description: data.data.description
#    }
#    $scope.deptId = data.data.deptId
#  return