angular.module \myapp, <[ui.choices]>

myctrl = ($scope) ->
  $scope.transportation = []
  $scope.fruit = []
  $scope.fruit11multi = true
  $scope.fruit11 =
    multi: true
    value: {}
    data: [
      { name: "Banana", value: 1, fallback: true, btntype: 'btn-primary' },
      { name: "Graphfruit", value: 2 },
      { name: "Pitaya", value: 3, active: true }
    ]
