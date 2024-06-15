<section class="py-5">
    <div class="container">
        <div class="card rounded-0 card-outline card-green shadow px-4 px-lg-5 mt-5">
            <div class="row">
                <div class="card-body">
                    <?php include "contact.html" ?>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    $(document).scroll(function() { 
        $('#topNavBar').removeClass('bg-green navbar-light navbar-dark bg-gradient-green text-light')
        if($(window).scrollTop() === 0) {
           $('#topNavBar').addClass('navbar-dark bg-green text-light')
        }else{
           $('#topNavBar').addClass('navbar-dark bg-gradient-green ')
        }
    });
    $(function(){
        $(document).trigger('scroll')
    })
</script>