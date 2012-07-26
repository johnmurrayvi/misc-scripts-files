#!/bin/bash

base=aosp
#base=cm

device=toro

workd=${HOME}/android/temp

vdate=071212
ver=jb

gappn=gapps-${ver}-${vdate}
gappd=$workd/$gappn
gappsys=$gappd/system
gappz=$gappd.zip

#outd=${HOME}/android/$base/out/target/product/$device
#otaz=`ls $outd | grep $USER.zip`
#ota=$outd/$otaz


list_google_files()
{
cat << EOF
app/ChromeBookmarksSyncAdapter.apk
app/GalleryGoogle.apk
app/GenieWidget.apk
app/GMail.apk
app/GoogleBackupTransport.apk
app/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter.apk
app/GoogleEars.apk
app/GoogleFeedback.apk
app/GoogleLoginService.apk
app/GooglePartnerSetup.apk
app/GoogleServicesFramework.apk
app/GoogleTTS.apk
app/MarketUpdater.apk
app/MediaUploader.apk
app/NetworkLocation.apk
app/OneTimeInitializer.apk
app/Phonesky.apk
app/PlusOne.apk
app/SetupWizard.apk
app/Talk.apk
app/Velvet.apk
app/VoiceSearch.apk
app/YouTube.apk
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/permissions/features.xml
etc/g.prop
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libfilterpack_facedetect.so
lib/libflint_engine_jni_api.so
lib/libfrsdk.so
lib/libgcomm_jni.so
lib/libgoogle_recognizer_jni.so
lib/libpicowrapper.so
lib/libspeexwrapper.so
lib/libvideochat_jni.so
lib/libvideochat_stabilize.so
lib/libvoicesearch.so
lib/libpatts_engine_jni_api.so
lib/libvorbisencoder.so
tts/lang_pico/de-DE_gl0_sg.bin
tts/lang_pico/de-DE_ta.bin
tts/lang_pico/es-ES_ta.bin
tts/lang_pico/es-ES_zl0_sg.bin
tts/lang_pico/fr-FR_nk0_sg.bin
tts/lang_pico/fr-FR_ta.bin
tts/lang_pico/it-IT_cm0_sg.bin
tts/lang_pico/it-IT_ta.bin
usr/srec/en-US/acoustic_model
usr/srec/en-US/c_fst
usr/srec/en-US/clg
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/contacts.abnf
usr/srec/en-US/dict
usr/srec/en-US/dictation.config
usr/srec/en-US/embed_phone_nn_model
usr/srec/en-US/embed_phone_nn_state_sym
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/ep_acoustic_model
usr/srec/en-US/g2p_fst
usr/srec/en-US/google_hotword.config
usr/srec/en-US/google_hotword_clg
usr/srec/en-US/google_hotword_logistic
usr/srec/en-US/grammar.config
usr/srec/en-US/hmmsyms
usr/srec/en-US/hotword_symbols
usr/srec/en-US/lintrans_model
usr/srec/en-US/metadata
usr/srec/en-US/norm_fst
usr/srec/en-US/normalizer
usr/srec/en-US/offensive_word_normalizer
usr/srec/en-US/phonelist
usr/srec/en-US/rescoring_lm
usr/srec/en-US/symbols
EOF
}

list_face_files()
{
cat <<EOF
app/FaceLock.apk
lib/libfacelock_jni.so
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-r0-ri30.4a/full_model.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rn30-ri30.5/full_model.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rp30-ri30.5/full_model.bin
vendor/pittpatt/models/recognition/face.face.y0-y0-22-b-N/full_model.bin
EOF
}


#if [ ! -f $gappd ] ; then
#	echo "No gapps to inject!"
#	exit 0
#fi
#if [ ! -f $ota ] ; then
#	echo "No OTA in out dir!"
#	exit 0
#fi
#if [ ! -d $workd ] ; then
#	mkdir $workd
#fi

#cp $ota $workd

otatemp=`ls | grep $USER.zip | sed -e s/$USER.zip/$USER/g`

cd $workd

if [ ! -d $gappd ] ; then
	unzip $gappz -d $gappd
fi

if [ ! -d $otatemp ] ; then
	unzip `ls | grep $USER.zip` -d $otatemp
fi

cd $otatemp

echo ""
echo "Injecting Google prop files"
echo ""

list_google_files | while read FILE; do
	if [ -f ./system/$FILE ] ; then
#		echo "*** OVERWRITE WARNING *** $gappn/system/$FILE /system/$FILE"
		echo "*** SKIPPING *** $gappn/system/$FILE"
	else
#		echo "cp $gappn/system/$FILE $otatemp/system/$FILE"
		echo "cp $gappn/system/$FILE --> $otatemp/system/$FILE"
	fi
done

echo ""
echo "Injecting Face Unlock prop files"
echo ""

list_face_files | while read FILE; do
	if [ -f ./system/$FILE ] ; then
#		echo "*** OVERWRITE WARNING *** $gappn/system/$FILE /system/$FILE"
		echo "*** SKIPPING *** $gappn/system/$FILE"
	else
#		echo "cp $gappn/system/$FILE $otatemp/system/$FILE"
		echo "cp $FILE --> /system/$FILE"
	fi
done

echo ""
echo "Removing recovery files"
echo ""

updscpt=META-INF/com/google/android/updater-script

echo "rm -rf $otatemp/recovery"
sed -i '/package_extract_dir("recovery", "\/system");/d' $updscpt
sed -i '/set_perm(0, 0, 0544, "\/system\/etc\/install-recovery.sh");/d' $updscpt

