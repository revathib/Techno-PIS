
app.service 'designationsService', ($http) ->

  @createNewDesignation = (desigName,desigDescription,desigDepartment) ->
    console.log 'new designation added'
    $http
    .post(dbServer + '/addDesignation', params : {desigName:desigName,desigDescription:desigDescription,desigDepartment:desigDepartment})
    .success((data, status, headers, config) ->
#      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveDesignations = () ->
    $http
    .get(dbServer+'/retrieveDesignations')
    .success((data,status,headers,config) ->
      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )
  return

app.controller 'AddDesignationsCtrl', ($scope, designationsService, $location) ->
  $scope.createNew = ->
    designationsService.createNewDesignation($scope.designation.name, $scope.designation.description, $scope.designation.department).then (data) ->
      if data.data.result
        $window.location='#/adminDesignations'
    return

app.controller 'DesignationsCtrl', ($scope, designationsService , ngTableParams) ->
  $scope.designations = []
  designationsService.retrieveDesignations().then (data) ->
    $scope.designations = data.data
    console.log('hello3'+data)
    console.log('hello5'+data.length)
    console.log('hello'+$scope.designations.length)
  $scope.manageDesignation = new ngTableParams(
    page: 1 # show first page
    count: 10 # count per page
  ,
    total: $scope.designations.length # length of data
    console.log('hello2'+$scope.designations.length)
    console.log('helloworld');
    getData: ($defer, params) ->

      # use build-in angular filter

      orderedData = (if params.sorting() then $filter("orderBy")(filteredData, params.orderBy()) else $scope.designations)
      params.total orderedData.length # set total for recalc pagination
      $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
      return
  )
  return
