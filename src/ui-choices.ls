angular.module \ui.choices, <[]>
.directive \toggle ($compile) ->
  return
    restrict: 'E'
    replace: true
    transclude: true
    template: "<button ng-transclude></button>"
    scope: {model: '=ngModel', id: '='}
    link: (s,e,a) ->
      if !e.hasClass \ui => e.addClass \btn
      console.log e.attr \class
      if a[\ngModel] =>
        s.model = a[\active]!=undefined or !!s.model
        e.on \click ->
          e["#{if (s.model = !s.model) => \add else \remove}Class"] \active
          s.$apply!
        s.$watch \model (v) -> e["#{if v => \add else \remove}Class"] \active

.directive \choices ($compile) ->
  return
    restrict: 'E'
    replace: true
    transclude: true
    scope: {model: '=ngModel', id: '=', type: '@'}
    template: "<div ng-transclude></div>"

    link: (s, e, a) ->
      if !e.hasClass \ui => e.addClass \btn-group
      if a[\multi] => s.multi = s.$parent.$eval that
      else if a[\multi]=="" => s.multi = true
      update = (s, e, v) ->
        [d,v] = [s.data, (v and s.data[v]) or {}]
        k = [k for k of d]
        if v.e =>
          if (v.fb or !s.multi) and v.on =>
            k.map -> d[it]on = false
            v.on = true
          else
            (fb = k.filter(->d[it]fb))map -> d[it]on = false
            if !k.filter(->d[it]on)length and fb.length => d[fb.0]on = true
        k.map (i) ->
          if d[i]m => s.$parent.$eval "#{d[i]m}=#{d[i]on}"
          d[i]e["#{if d[i]on => \add else \remove}Class"] \active
        if s.type == "array" => s.model = k.filter(->d[it]on)map -> d[it]v
        else if s.type =="single" => s.model = k.filter(->d[it]on)[0] or undefined
        else
          s.model = {}
          k.map -> s.model[it] = !!d[it]on
      update s, e, null

      e.on \update (err,t)->
        update s, e, t
        s.$apply!
      s.$watch \model, (d) ->
        if !d or (!d.length and s.type=="array") => return
        if s.type=="array" => d = ["#{x}" for x in d]
        else if s.type=="single" => d = ["#d"]
        else d = [k for k of d]filter(-> d[it])
        for k,v of s.data
          v.e["#{if v.on = (k in d) => \add else \remove}Class"] \active
          if v.m => s.$parent.$eval "#{v.m}=#{v.on}"
      ,true

    controller: ($scope, $element) ->
      $scope.btntype = $element.attr \btn-type
      @node =
        d: {}
        add: (e,a) ->
          v = a[\value]
          @d[v] = {e, v, m: a[\ngModel], fb: a[\fallback]!=undefined, on: a[\active]!=undefined}
          if a[\ngModel] =>
            $scope.$parent.$watch that, (u) ~>
              @d[v]on = u
              setTimeout (~> e.parent!trigger \update, @d[v]v), 0
          setTimeout (~> e.parent!trigger \update, null), 0
        tgl: (v) -> @d[v]on = !@d[v]on
      $scope.data = @node.d
      @is-multi = -> $scope.multi
      @btntype = -> $scope.btntype
      @scope = -> $scope

.directive \choice ($compile) ->
  return
    restrict: 'E'
    transclude: true
    replace: true
    require: "^choices"
    scope: {id: '=', d: '=ngData'}
    template: "<label><span ng-transclude></span></label>"
    link: (s, e, a, c) ->
      if !e.hasClass \ui => e.addClass \btn
      if s.d =>
        a{value,fallback,active,ngModel} = s.d
        a.btnType? =s.d.btntype
      e.addClass if a[\btnType] => that else if c.btntype! => that else \btn-primary
      c.node.add e, a
      e.on \click ->
        r = c.node.tgl v = a[\value]
        setTimeout (-> e.parent!trigger \update, v), 0
