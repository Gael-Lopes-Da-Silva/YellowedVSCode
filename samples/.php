<?php // phpcs:ignore
/**
 * PHP is fun
 *
 * Shades of purple is genius.
 *
 * @param String hello Hello.
 * @param Number count Count of hells said.
 * @param Boolean isBye True or False.
 * @return Boolean
 * @package SOP
 * @since 1.0.0
 */

// Header.
get_header();

$ahmad = 'Ahmad';
$awais = 'Awais';

// Display the page to admins and subscribers only.
if ( current_user_can( 'administrator' ) || current_user_can( 'subscriber' ) ) {
	echo 'HELLO!';
} else {
	wp_safe_redirect( 'https://VSCode.pro', 302 );
	exit;
}

// Footer.
get_footer();

/**
 * Small Class.
 *
 * @since 1.0.0
 */
class Small {
	/**
	 * Name.
	 *
	 * @var String
	 * @since 1.0.0
	 */
	public static $name;

	/**
	 * Sum.
	 *
	 * @param Number $num1 First number.
	 * @param Number $num2 First number.
	 * @return Number
	 * @since 1.0.0
	 */
	public static function sum( $num1, $num2 ) {
		return $num1 + $num2;
	}
}

// SQL for the win.
$get = "SELECT *
			FROM blog
			WHERE country='$country'
			AND who='host'
			ORDER BY date DESC";

namespace Hyunk3l\PhpDesignPatterns\Creational\Builder;

use Hyunk3l\PhpDesignPatterns\Creational\Builder\Components\Box;
use Hyunk3l\PhpDesignPatterns\Creational\Builder\Components\Band;
use Hyunk3l\PhpDesignPatterns\Creational\Builder\Components\Movement;
use Hyunk3l\PhpDesignPatterns\Creational\Builder\Components\Hand;

class ClassicWatchBuilder implements WatchBuilderInterface
{
    private Watch $watch;

    public function createWatch(): WatchBuilderInterface
    {
        $this->watch = new ClassicWatch();
        return $this;
    }

    public function addBox(): WatchBuilderInterface
    {
        $this->watch->addComponent("Watch box", new Box());
        return $this;
    }

    public function addHands(): WatchBuilderInterface
    {
        $this->watch->addComponent("Seconds hand", new Hand());
        $this->watch->addComponent("Minutes hand", new Hand());
        $this->watch->addComponent("Hours hand", new Hand());
        return $this;
    }

    public function addBands(): WatchBuilderInterface
    {
        $this->watch->addComponent("Leather upper band", new Band());
        $this->watch->addComponent("Leather lower band", new Band());
        return $this;
    }

    public function addMovements(): WatchBuilderInterface
    {
        $this->watch->addComponent("Principal watch movement", new Movement());
        $this->watch->addComponent("Date watch movement", new Movement());
        return $this;
    }

    public function getWatch(): Watch
    {
        return $this->watch;
    }
}
