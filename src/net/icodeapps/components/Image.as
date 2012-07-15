package net.icodeapps.components
{
  import flash.events.Event;
  import flash.events.MouseEvent;

  import mx.events.CloseEvent;

  import spark.components.Image;
  import spark.components.supportClasses.ButtonBase;
  import spark.components.supportClasses.TextBase;

  [Event(name="close", type="mx.events.CloseEvent")]

  public class Image extends spark.components.Image
  {
    //---------------------------------------------------------------------
    //
    //          Skin Parts
    //
    //---------------------------------------------------------------------

    //-----------------------------
    //          closeButton
    //-----------------------------

    [SkinPart(required="true")]
    /**
     * Allows closing the component. The closing wil happen indirectly, preferable by a view controller.
     */
    public var closeButton:ButtonBase;

    //-----------------------------
    //          labelDisplay
    //-----------------------------

    [SkinPart(required="true")]
    /**
     * Displays the label text of the component.
     */
    public var labelDisplay:TextBase;

    //---------------------------------------------------------------------
    //
    //          Properties
    //
    //---------------------------------------------------------------------

    private var _label:String, _labelChanged:Boolean;

    [Bindable("labelChanged")]
    /**
     * The label being displayed by the component.
     */
    public function get label():String
    {
      return _label;
    }

    public function set label(value:String):void
    {
      if (_label === value)
      {
        return;
      }
      _label = value;
      _labelChanged = true;
      invalidateProperties();
      dispatchEvent(new Event("labelChanged"));
    }

    //---------------------------------------------------------------------
    //
    //          Constructor
    //
    //---------------------------------------------------------------------

    public function Image()
    {
    }

    //---------------------------------------------------------------------
    //
    //          Event Handler
    //
    //---------------------------------------------------------------------

    /**
     * Invoked when the closeButton skin part is clicked.
     *
     * @param event The MouseEvent passed when the listener is invoked.
     */
    private function closeButton_clickHandler(event:MouseEvent):void
    {
      dispatchEvent(new CloseEvent(CloseEvent.CLOSE, true));
    }

    //---------------------------------------------------------------------
    //
    //          Overridden Methods
    //
    //---------------------------------------------------------------------

    /**
     * @inheritDoc
     */
    override protected function commitProperties():void
    {
      super.commitProperties();

      if (_labelChanged)
      {
        _labelChanged = false;
        labelDisplay.text = _label;
      }
    }

    /**
     * @inheritDoc
     */
    override protected function partAdded(partName:String, instance:Object):void
    {
      super.partAdded(partName, instance);

      if (instance == closeButton)
      {
        closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
      }
    }

    /**
     * @inheritDoc
     */
    override protected function partRemoved(partName:String, instance:Object):void
    {
      super.partRemoved(partName, instance);

      if (instance == closeButton)
      {
        closeButton.removeEventListener(MouseEvent.CLICK, closeButton_clickHandler);
      }
    }
  }
}
