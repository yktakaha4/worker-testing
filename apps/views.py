import subprocess
import time

from django.http import HttpResponse, JsonResponse


def index(request):
    return HttpResponse("Working.")


def cpu_bound(request):
    seconds = int(request.GET.get("seconds", 10))

    start_time = time.time()
    while time.time() - start_time < seconds:
        pass

    return JsonResponse(
        {
            "seconds": seconds,
        }
    )


def memory_bound(request):
    seconds = float(request.GET.get("seconds", 10))
    mb = int(request.GET.get("mb", 1024))

    _ = [0] * (mb * 1024 * 1024 // 4)
    time.sleep(seconds)

    return JsonResponse(
        {
            "seconds": seconds,
            "mb": mb,
        }
    )


def io_bound(request):
    seconds = float(request.GET.get("seconds", 10))

    subprocess.run(["sleep", str(seconds)])

    return JsonResponse(
        {
            "seconds": seconds,
        }
    )
