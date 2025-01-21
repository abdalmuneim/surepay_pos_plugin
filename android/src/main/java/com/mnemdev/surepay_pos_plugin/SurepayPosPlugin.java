package com.mnemdev.surepay_pos_plugin;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.sure.poslibrary.usbIntegration.ActionsError;
import com.sure.poslibrary.usbIntegration.SureUsb;
import com.sure.poslibrary.usbIntegration.TerminalError;
import com.sure.poslibrary.usbIntegration.TransactionInformation;
import com.sure.poslibrary.usbIntegration.callbacks.FinancialTransactionCallback;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class SurepayPosPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  private MethodChannel channel;
  private EventChannel eventChannel;
  private Activity activity;
  private EventChannel.EventSink eventSink;
  private static final String CHANNEL = "com.mnemdev.surepayposplugin/channel";
  private static final String EVENT_CHANNEL = "com.mnemdev.surepayposplugin/event";
  private Map<String, Object> data = new HashMap<>();

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL);
    channel.setMethodCallHandler(this);

    eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), EVENT_CHANNEL);
    eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
      @Override
      public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
      }

      @Override
      public void onCancel(Object arguments) {
        eventSink = null;
      }
    });
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "usbConnectionInitialize":
        SureUsb.getInstance().openConnection(activity);
        append("initialized", "initialized");
        sendOtherData("");
        result.success(data.toString());
        break;

      case "sendAmount":
        String amount = call.argument("amount");
        SureUsb.getInstance().sendAmount(amount, new FinancialTransactionCallback() {
          @Override
          public void OnGetConnectionError(ActionsError error) {
            String message = "purchase with amount " + amount + " got Connection Error " + error.toString();
            append("OnGetConnectionError", message);
            sendOtherData(message);
          }

          @Override
          public void OnGetTransactionInformation(TransactionInformation model) {
            String message = "purchase with amount " + amount + " got response " + model.toString();
            append("OnGetTransactionInformation", message);
            sendOtherData(model.toString());
          }

          @Override
          public void OnGetTerminalError(TerminalError error) {
            String message = "purchase with amount " + amount + " got Terminal Error " + error.toString();
            append("OnGetConnectionError", message);
            sendOtherData(message);
          }
        });
        result.success(data.toString());
        break;

      case "clearData":
        data.clear();
        result.success(data.toString());
        break;

      default:
        append("default", "default");
        result.notImplemented();
        break;
    }
  }

  private void append(String key, String dataSTR) {
    data.put(key, dataSTR);
  }

  private void sendOtherData(final String otherData) {
    data.put("sendOtherData", otherData);
    if (eventSink != null) {
      activity.runOnUiThread(() -> eventSink.success(otherData));
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    eventChannel.setStreamHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }
}