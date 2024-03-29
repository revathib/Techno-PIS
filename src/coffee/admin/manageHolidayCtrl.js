// Generated by CoffeeScript 1.6.3
app.service('holidaysService', function($http) {
  this.createNewHoliday = function(holidayName, holidayDate) {
    console.log('new holiday added');
    return $http.post(dbServer + '/addHoliday', {
      params: {
        holidayName: holidayName,
        holidayDate: holidayDate
      }
    }).success(function(data, status, headers, config) {
      return data;
    }).error(function(data, status, headers, config) {});
  };
  this.retrieveHolidays = function() {
    console.log("holidays");
    return $http.get(dbServer + '/retrieveHolidays').success(function(data, status, headers, config) {
      console.log(data);
      return data;
    }).error(function(data, status, headers, config) {});
  };
  this.retrieveLeavesById = function(deptId) {
    return $http.get(dbServer + '/retrieveLeavesById', {
      params: {
        leaveId: leaveId
      }
    }).success(function(data, status, headers, config) {
      return data;
    }).error(function(data, status, headers, config) {});
  };
  this.editLeaves = function(application, leaveId) {
    return $http.post(dbServer + 'editLeaves', {
      application: application,
      leaveId: leaveId
    }).success(function(data, status, headers, config) {
      return data;
    }).error(function(data, status, headers, config) {});
  };
});

app.controller('AddHolidayCtrl', function($scope, $location, holidaysService) {
  return $scope.createNew = function() {
    holidaysService.createNewHoliday($scope.holiday.name, $scope.holiday.date).then(function(data) {
      if (data.data.result) {
        return $window.location = '#/adminDepartmentLeaves';
      }
    });
    return;
    return $location.path('/adminLeaves');
  };
});

app.controller('HolidaysCtrl', function($scope, holidaysService) {
  $scope.holidays = [];
  holidaysService.retrieveHolidays().then(function(data) {
    return $scope.holidays = data.data;
  });
});

app.controller('HolidaysCtrl', function($scope, holidaysService, $filter, ngTableParams) {
  holidaysService.retrieveHolidays().then(function(data) {
    data = data.data;
    $scope.holidaysTable = new ngTableParams({
      page: 1,
      count: 5,
      sorting: {
        holidayId: 'asc'
      }
    }, {
      total: data.length,
      getData: function($defer, params) {
        var filteredData, orderedData;
        filteredData = (params.filter() ? $filter("filter")(data, params.filter()) : data);
        orderedData = (params.sorting() ? $filter("orderBy")(filteredData, params.orderBy()) : data);
        params.total(orderedData.length);
        $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()));
      }
    });
  });
});

/*
//@ sourceMappingURL=manageHolidayCtrl.map
*/
