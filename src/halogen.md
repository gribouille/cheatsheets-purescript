# Halogen


`HalogenM state action slots output m a`:
- `state`: component's state
- `action`: type of actions; events internal to the component that can be evaluated
- `slots`:
- `output`:
- `m`:
- `a`: result of the HalogenM expression
  - handleAction :: Action            -> H.HalogenM State Action Slots Output m Unit
  - handleQuery  :: forall a. Query a -> H.HalogenM State Action Slots Output m (Maybe a)

`Component query input output m`:
- `query :: Type -> Type`: query algebra; the requests that can be made of the component
- `input :: Type`: input value that will be received when the parent of this component renders
- `output :: Type`: type of messages the component can raise
- `m :: Type -> Type`: effect monad used during evaluation



`ComponentHTML action slots m`:
- `action`: type of actions, events internal to the component that can be evaluated with the handleAction function
- `slots`: set of child component types that can be used in the HTML
- `m`: monad used by the child component during evaluation

`type ComponentHTML action slots m = HTML (ComponentSlot slots m action) action`

type ComponentHTML f = HTML Void (f Unit)