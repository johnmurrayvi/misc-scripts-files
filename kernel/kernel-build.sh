#!/bin/bash

app=""
rev=""

if [ $1 ] ; then
	if ! [[ "$1" =~ ^[0-9]+([.][0-9]+)?$ ]] ; then
		app=$1
	else
		rev=$1
	fi

	if [ $2 ] ; then
		if [ -n $app ] ; then
			rev=$2
		elif [ -n $rev ] ; then
			app=$2
		fi
	fi
fi

if [ -z $app ] && [ -z $rev ] ; then
	CONCURRENCY_LEVEL=`getconf _NPROCESSORS_ONLN` fakeroot make-kpkg --initrd --arch-in-name kernel_image kernel_headers modules_image
elif [ -n $app ] && [ -z $rev ] ; then
	CONCURRENCY_LEVEL=`getconf _NPROCESSORS_ONLN` fakeroot make-kpkg --initrd --arch-in-name --append-to-version=-$app kernel_image kernel_headers modules_image
elif [ -z $app ] && [ -n $rev ] ; then
	CONCURRENCY_LEVEL=`getconf _NPROCESSORS_ONLN` fakeroot make-kpkg --initrd --arch-in-name --revision=$rev kernel_image kernel_headers modules_image
elif [ -n $app ] && [ -n $rev ] ; then
	CONCURRENCY_LEVEL=`getconf _NPROCESSORS_ONLN` fakeroot make-kpkg --initrd --arch-in-name --revision=$rev --append-to-version=-$app kernel_image kernel_headers modules_image
fi
