var _module = angular.module;
angular.module = function(name, dependencies){
  var module = null;
  if(!(dependencies instanceof Array)){
    return _module.call(null, name); // Just the getter
  };

  dependencies.push('songFlux');
  module = _module.call(null, name, dependencies) // A new module

  module.action = module.action || function(ActionCtor){
    ActionFactory.$inject = [ 'songFactory' ];
    function ActionFactory(song){
      ActionCtor.prototype.getDispatcher = function(){
        this.dispatcher = this.dispatcher || song.getDispatcher(this.module);
        return this.dispatcher;
      };
      ActionCtor.prototype.dispatch = function(){
        this.getDispatcher().dispatch(this);
        this.dispatcher.dispatch(this);
      };
      return ActionCtor;
    }
    module.factory(ActionCtor.name, ActionFactory);
    return module;
  };

  return module;
};
