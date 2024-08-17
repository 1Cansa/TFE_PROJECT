import Swal from 'sweetalert2';

export const confirmSwalMixin = Swal.mixin({
    text: 'Êtes-vous sûr de vouloir effectué cette action ?',
    showDenyButton: false,
    showCancelButton: true,
    customClass: {
        confirmButton: 'btn btn-success',
        cancelButton: 'btn btn-dim btn-secondary'
    },
    buttonsStyling: false
});

export const toastSwalMixin = Swal.mixin({
    toast: true,
    position: 'top-end',
    timer: 30000,
    showCloseButton: true,
    timerProgressBar: true,
    showConfirmButton: false,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
    }
});

export const confirmation = async (action, onConfirm, onCancel) => {
    await confirmSwalMixin
        .fire({
            confirmButtonText: action,
            customClass: {
                confirmButton: 'btn btn-danger',
                cancelButton: 'btn btn-dim btn-light',
            }
        })
        .then((result) => {
            if (result.isConfirmed) {
                onConfirm();
            }
        });
}

export const toast = async (type, message, timer = 1500) => {
    await toastSwalMixin.fire({
        timer: timer,
        icon: type,
        html: message,
    });
}
