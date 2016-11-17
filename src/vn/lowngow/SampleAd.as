package vn.lowngow
{
    import com.hinish.spec.iab.vpaid.AdEvent;
    import com.hinish.spec.iab.vpaid.AdMovieClipBase;

    import flash.display.Sprite;
    import flash.system.Security;

    import vn.lowngow.util.Logger;

    /**
     * An example VPAID ad.
     *
     * @langversion 3.0
     * @playerversion Flash 10
     */
    public class SampleAd extends AdMovieClipBase
    {
        private var _bg:Sprite;
        private var _logger:Logger;
        private var _instanceId:uint;

        public function SampleAd()
        {
            Security.allowDomain('*');
            Security.allowInsecureDomain('*');

            this._instanceId =  Math.random() * 10e10;
            this._logger = new Logger(this._instanceId, true);
            _logger.traceLog('called constructor');

            super();
        }

        public function getVPAID():*
        {
            _logger.traceLog('player called getVPAID');
            return this;
        }

        /* *************************
         * Part of VPAID spec
         * ************************/
        /**
         * @inheritDoc
         */
        override public function handshakeVersion(playerVPAIDVersion:String):String
        {
            _logger.traceLog('player called handshakeVersion');
            super.handshakeVersion(playerVPAIDVersion);
            return '1.0'; // '1.0b1'
        }

        /**
         * @inheritDoc
         */
        override public function initAd(width:Number, height:Number, viewMode:String, desiredBitrate:Number, creativeData:String = '', environmentVars:String = ''):void
        {
            _logger.traceLog('player called initAd');
            super.initAd(width, height, viewMode, desiredBitrate, creativeData, environmentVars);

            updateBackground(width, height);

            dispatchEvent(new AdEvent(AdEvent.AD_LOADED));
        }

        /**
         * @inheritDoc
         */
        override public function resizeAd(width:Number, height:Number, viewMode:String):void
        {
            super.resizeAd(width, height, viewMode);
        }

        /**
         * @inheritDoc
         */
        override public function startAd():void
        {
            _logger.traceLog('player called startAd');
            super.startAd();
        }

        /**
         * @inheritDoc
         */
        override public function stopAd():void
        {
            super.stopAd();
        }

        /**
         * @inheritDoc
         */
        override public function pauseAd():void
        {
            super.pauseAd();
        }

        /**
         * @inheritDoc
         */
        override public function resumeAd():void
        {
            super.resumeAd();
        }

        /**
         * @inheritDoc
         */
        override public function expandAd():void
        {
            super.expandAd();
        }

        /**
         * @inheritDoc
         */
        override public function collapseAd():void
        {
            super.collapseAd();
        }

        /**
         * @inheritDoc
         */
        override public function get adLinear():Boolean
        {
            return false;
        }

        /**
         * @inheritDoc
         */
        override public function get adExpanded():Boolean
        {
            return super.adExpanded;
        }

        /**
         * @inheritDoc
         */
        override public function get adRemainingTime():Number
        {
            return super.adRemainingTime;
        }

        /**
         * @inheritDoc
         */
        override public function set adVolume(value:Number):void
        {
            super.adVolume = value;
        }

        /* *************************
         * other SampleAd methods
         * ************************/
        private function updateBackground(width:Number, height:Number):void
        {
            if (!_bg)
            {
                addChild(_bg = new Sprite());
            }

            _bg.graphics.clear();
            _bg.graphics.beginFill(0xFF0000, 0.7);
            _bg.graphics.drawRect(0, 0, width, height);
            _bg.graphics.endFill();
            _bg.graphics.beginFill(0x00FF00, 0.9);
            _bg.graphics.drawRect(10, 10, width - 20, height - 20);
            _bg.graphics.endFill();
        }
    }
}